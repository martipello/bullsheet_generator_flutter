import 'package:universal_html/html.dart' as html;
import 'package:universal_html/parsing.dart' as parser;

import 'package:web_scraper/web_scraper.dart';

import '../api/models/api_response.dart';
import '../api/models/extensions/job_source_extension.dart';
import '../api/models/job.dart' as jb;
import '../api/models/job_search_request.dart';
import '../api/models/job_source.dart';
import '../extensions/date_time_extension.dart';
import '../extensions/element_extension.dart';
import '../extensions/iterable_extension.dart';
import '../extensions/job_extension.dart';
import '../extensions/string_extension.dart';
import '../utils/console_output.dart';
import '../utils/constants.dart';

typedef JobBuilder = List<jb.Job> Function(
  JobSearchRequest? jobSearchRequest,
  html.HtmlDocument htmlDocument,
  JobSource jobSource,
);

class BullsheetRepository {
  Future<List<jb.Job>> getJobs(
    JobSearchRequest? jobSearchRequest,
  ) async {
    final _jobList = await Future.wait<ApiResponse<List<jb.Job>>>(
      jobSearchRequest?.jobSource.map(
            (source) => _scrapeWebPage(
              _getJobBuilder(source),
              jobSearchRequest,
              source,
            ),
          ) ??
          [],
    );

    final flattenList = _jobList
        .map<List<jb.Job>>(
          (response) {
            if (response.status == Status.ERROR) {
              return [_createErrorJob()];
            } else {
              return response.data ?? [];
            }
          },
        )
        .expand(
          (job) => job,
        )
        .toList();
    final today = DateTime.now();
    flattenList.sort(
      (firstJob, secondJob) => firstJob.dateApplied?.isBefore(
                secondJob.dateApplied ?? today,
              ) ==
              true
          ? 1
          : 0,
    );
    return flattenList;
  }

  Future<ApiResponse<List<jb.Job>>> _scrapeWebPage(
    JobBuilder jobBuilder,
    JobSearchRequest? jobSearchRequest,
    JobSource jobSource,
  ) async {
    try {
      final _baseUrl = jobSource.baseUrl();
      final webScraper = WebScraper(_baseUrl);
      final _searchString = jobSource.searchQuery(jobSearchRequest);
      if (await webScraper.loadWebPage(_searchString)) {
        log('YOUGOV').d('SCRAPE $_baseUrl$_searchString');

        final _document = webScraper.getPageContent();
        final _html = parser.parseHtmlDocument(_document);
        final _jobs = jobBuilder.call(
          jobSearchRequest,
          _html,
          jobSource,
        );
        return ApiResponse.completed(_jobs);
      } else {
        return ApiResponse.error('Failed to load page.');
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  JobBuilder _getJobBuilder(
    JobSource jobSource,
  ) {
    switch (jobSource) {
      case JobSource.indeed:
        return _createIndeedJobs;
      case JobSource.totalJobs:
        return _createIndeedJobs;
      case JobSource.youGov:
        return _createYouGovJobs;
      default:
        return (_, _a, _b) => [];
    }
  }

  List<jb.Job> _createYouGovJobs(
    JobSearchRequest? jobSearchRequest,
    html.HtmlDocument _html,
    JobSource jobSource,
  ) {
    var _jobs = <jb.Job>[];

    final _jobListElement = _html.querySelector('#search_results');
    final _jobListItems = _jobListElement?.children.where(
          (element) => element.className == 'search-result',
        ) ??
        [];

    for (var jobItem in _jobListItems) {
      final _jobBuilder = jb.JobBuilder();
      _jobBuilder.id = jb.Job().createJobId();
      final _titleQuery = jobItem.querySelector('h3 > a');
      final _details = jobItem.querySelectorAll('ul > li');
      if (_details.isNotEmpty) {
        final _date = _details[0];
        _jobBuilder.datePosted = _date.text;
      }
      if (_details.length > 1) {
        final _company = _details[1];
        final _companyAndLocation = _company.text?.split('-');
        _jobBuilder.company = _companyAndLocation?.first;
        _jobBuilder.location = _companyAndLocation?.last;
      }
      _jobBuilder.title = _titleQuery?.innerHtml?.trim();

      for (var child in jobItem.children) {
        for(var childrensChild in child.children) {
          if(childrensChild.attributes.containsKey('href')) {
            final _url = childrensChild.attributes['href'].toString();
            _jobBuilder.url = _url;
          }
        }
      }

      if (_jobBuilder.title != null) {
        _jobs.add(
          _jobBuilder.build(),
        );
      }
    }

    return _jobsWithDates(jobSearchRequest, _jobs);
  }

  List<jb.Job> _createIndeedJobs(
    JobSearchRequest? jobSearchRequest,
    html.HtmlDocument _html,
    JobSource jobSource,
  ) {
    var _jobs = <jb.Job>[];
    final _jobListElement = _html.querySelector('#mosaic-provider-jobcards > ul');
    final _jobListItems = _jobListElement?.children.where(
          (element) => element.nodeName == 'LI',
        ) ??
        [];

    for (var jobItem in _jobListItems) {
      final _titleQuery = jobItem.indeedTitleQuery();
      final _companyQuery = jobItem.indeedCompanyQuery();
      final _locationQuery = jobItem.indeedLocationQuery();
      final _urlQuery = jobItem.indeedUrlQuery();

      final _title = _titleQuery?.children.firstWhereOrNull(
        (element) => element.className == 'jcs-JobTitle',
      );
      final _url = _urlQuery?.getAttribute('id')?.scrapeIndeedId();

      if (_title?.text != null) {
        _jobs.add(
          jb.Job(
            (p0) => p0
              ..id = jb.Job().createJobId()
              ..title = _title?.text
              ..company = _companyQuery?.text
              ..location = _locationQuery?.text ?? ''
              ..url = jobSource.encodeIndeedUrl(_url ?? ''),
          ),
        );
      }
    }

    return _jobsWithDates(jobSearchRequest, _jobs);
  }

  List<jb.Job> _jobsWithDates(
    JobSearchRequest? jobSearchRequest,
    List<jb.Job> _jobs,
  ) {
    final _daysBetween = jobSearchRequest?.fromDate?.getDaysBetweenFilled(
          jobSearchRequest.toDate ?? DateTime.now(),
          _jobs.length,
        ) ??
        [];

    return _jobs
        .mapIndexed(
          (e, index) => e.rebuild(
            (p0) => p0..dateApplied = (_daysBetween.length > index ? _daysBetween[index] : DateTime.now()),
          ),
        )
        .toList();
  }

  jb.Job _createErrorJob() {
    return jb.Job((b) => b
      ..id = Constants.errorId
      ..title = 'Bullsheet! Something went wrong.');
  }
}

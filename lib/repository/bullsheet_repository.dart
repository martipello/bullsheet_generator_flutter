import 'package:universal_html/html.dart' as html;
import 'package:universal_html/parsing.dart' as parser;

import 'package:web_scraper/web_scraper.dart';

import '../api/models/api_response.dart';
import '../api/models/extensions/job_source_extension.dart';
import '../api/models/job.dart';
import '../api/models/job_search_request.dart';
import '../api/models/job_source.dart';
import '../extensions/date_time_extension.dart';
import '../extensions/iterable_extension.dart';
import '../extensions/job_extension.dart';
import '../extensions/string_extension.dart';
import '../utils/console_output.dart';
import '../utils/constants.dart';

typedef JobBuilder = List<Job> Function(
  JobSearchRequest? jobSearchRequest,
  html.HtmlDocument htmlDocument,
  JobSource jobSource,
);

class BullsheetRepository {
  Future<List<Job>> getJobs(
    JobSearchRequest? jobSearchRequest,
  ) async {
    final _jobList = await Future.wait<ApiResponse<List<Job>>>(
      jobSearchRequest?.jobSource.map(
            (source) => _scrapeWebPage(
              _getJobBuilder(source),
              jobSearchRequest,
              source,
            ),
          ) ??
          [],
    );

    return _jobList
        .map<List<Job>>(
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
  }

  Future<ApiResponse<List<Job>>> _scrapeWebPage(
    JobBuilder jobBuilder,
    JobSearchRequest? jobSearchRequest,
    JobSource jobSource,
  ) async {
    try {
      final _baseUrl = jobSource.baseUrl();
      final webScraper = WebScraper(_baseUrl);
      final _searchString = jobSource.searchQuery(jobSearchRequest);
      if (await webScraper.loadWebPage(_searchString)) {
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
        return _createIndeedJobs;
      default:
        return (_, _a, _b) => [];
    }
  }

  List<Job> _createIndeedJobs(
    JobSearchRequest? jobSearchRequest,
    html.HtmlDocument _html,
    JobSource jobSource,
  ) {
    var _jobs = <Job>[];
    final _jobListElement = _html.querySelector('#mosaic-provider-jobcards > ul');
    final _jobListItems = _jobListElement?.children.where(
          (element) => element.nodeName == 'LI',
        ) ??
        [];

    for (var jobItem in _jobListItems) {
      //TODO these dont work
      // final _titleQuery = jobItem.indeedTitleQuery();
      // final _urlQuery = jobItem.indeedUrlQuery();
      // final _locationQuery = jobItem.indeedLocationQuery();
      // final _companyQuery = jobItem.indeedCompanyQuery();

      //TODO these do work

      final _titleQuery = jobItem.querySelector(
        'div > div.slider_item > div > table.jobCard_mainContent.big6_visualChanges > tbody > tr > td > '
        'div.heading4.color-text-primary.singleLineTitle.tapItem-gutter > h2',
      );

      final _urlQuery = jobItem.querySelector(
        'div > div.slider_item > div > table.jobCard_mainContent.big6_visualChanges > tbody > tr > td > '
        'div.heading4.color-text-primary.singleLineTitle.tapItem-gutter > h2 > a',
      );

      final _locationQuery = jobItem.querySelector(
        'div.heading6.company_location.tapItem-gutter.companyInfo > div',
      );
      final _companyQuery = jobItem.querySelector(
        'div.heading6.company_location.tapItem-gutter.companyInfo '
        '> span.companyName > a',
      );

      log('DATA').d('JOB $jobItem TITLE $_titleQuery');

      final _title = _titleQuery?.children.firstWhereOrNull(
        (element) => element.className == 'jcs-JobTitle',
      );
      final _url = _urlQuery?.getAttribute('id')?.scrapeIndeedId();

      if (_title?.text != null) {
        _jobs.add(
          Job(
            (p0) => p0
              ..id = Job().createJobId()
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

  List<Job> _jobsWithDates(
    JobSearchRequest? jobSearchRequest,
    List<Job> _jobs,
  ) {
    final _daysBetween = jobSearchRequest?.fromDate?.getDaysBetweenFilled(
          jobSearchRequest.toDate ?? DateTime.now(),
          _jobs.length,
        ) ??
        [];

    return _jobs
        .mapIndexed(
          (e, index) => e.rebuild(
            (p0) => p0..date = (_daysBetween.length > index ? _daysBetween[index] : DateTime.now()),
          ),
        )
        .toList();
  }

  Job _createErrorJob() {
    return Job((b) => b
      ..id = Constants.errorId
      ..title = 'Bullsheet! Something went wrong.');
  }
}

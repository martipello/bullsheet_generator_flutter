import 'package:universal_html/html.dart' as html;
import 'package:universal_html/parsing.dart' as parser;

import 'package:web_scraper/web_scraper.dart';

import '../api/models/api_response.dart';
import '../api/models/extensions/job_source_extension.dart';
import '../api/models/job.dart';
import '../api/models/job_search_request.dart';
import '../api/models/job_source.dart';
import '../extensions/iterable_extension.dart';
import '../extensions/job_extension.dart';
import '../extensions/string_extension.dart';
import '../utils/console_output.dart';

class BullsheetRepository {
  Future<List<ApiResponse<List<Job>>>> getJobs(
    JobSearchRequest? jobSearchRequest,
  ) async {
    return Future.wait<ApiResponse<List<Job>>>(
      jobSearchRequest?.jobSource.map(
        (source) => _scrapeWebPage(
          jobSearchRequest,
          source,
        ),
      ) ?? [],
    );
  }

  Future<ApiResponse<List<Job>>> _scrapeWebPage(
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
        final _jobs = _createIndeedJobs(_html, jobSource);
        return ApiResponse.completed(_jobs);
      } else {
        log('ERROR').d('Failed to load page.');
        return ApiResponse.error('Failed to load page.');
      }
    } catch (e) {
      log('ERROR').d('Failed to load page.');
      return ApiResponse.error(e.toString());
    }
  }

  List<Job> _createIndeedJobs(
    html.HtmlDocument _html,
    JobSource jobSource,
  ) {
    var _jobs = <Job>[];
    final _jobListElement = _html.querySelector('#mosaic-provider-jobcards > ul');
    final _jobListItems = _jobListElement?.children.where((element) => element.nodeName == 'LI') ?? [];

    for (var jobItem in _jobListItems) {
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

      final _title = _titleQuery?.children.firstWhereOrNull((element) => element.className == 'jcs-JobTitle');
      final _url = _urlQuery?.getAttribute('id')?.scrapeIndeedId();

      if (_title != null) {
        _jobs.add(
          Job(
            (p0) => p0
              ..id = Job().createJobId()
              ..title = _title.text
              ..company = _companyQuery?.text
              ..location = _locationQuery?.text ?? ''
              ..url = jobSource.encodeIndeedUrl(_url ?? ''),
          ),
        );
      }
    }
    return _jobs;
  }
}

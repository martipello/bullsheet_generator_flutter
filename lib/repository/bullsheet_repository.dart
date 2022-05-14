import 'package:html/parser.dart' as html;

import 'package:web_scraper/web_scraper.dart';

import '../api/models/api_response.dart';
import '../api/models/extensions/job_source_extension.dart';
import '../api/models/job_search_request.dart';
import '../api/models/job_source.dart';
import '../utils/console_output.dart';

class BullsheetRepository {
  Future<ApiResponse> scrapeJobSources(
    JobSearchRequest? jobSearchRequest,
  ) async {
    //TODO fix this to be a builder pattern maybe make a object to hold all lists
    final jobSources = jobSearchRequest?.jobSource;
    if (jobSources?.any((p0) => p0 == JobSource.totalJobs) == true) {
      // _scrapeWebPage(jobSearchRequest, JobSource.totalJobs);
    }
    if (jobSources?.any((p0) => p0 == JobSource.indeed) == true) {
      _scrapeWebPage(jobSearchRequest, JobSource.indeed);
    }
    if (jobSources?.any((p0) => p0 == JobSource.youGov) == true) {
      // _scrapeWebPage(jobSearchRequest, JobSource.youGov);
    }
    return ApiResponse.error('');
  }

  Future<ApiResponse> _scrapeWebPage(
    JobSearchRequest? jobSearchRequest,
    JobSource jobSource,
  ) async {
    switch (jobSource) {
      case JobSource.indeed:
        return _indeedJobElements(jobSearchRequest, jobSource);
      case JobSource.totalJobs:
        return _indeedJobElements(jobSearchRequest, jobSource);
      case JobSource.youGov:
        return _indeedJobElements(jobSearchRequest, jobSource);
      default:
        return ApiResponse.error('Something went wrong.');
    }
  }

  Future<ApiResponse<String>> _indeedJobElements(
    JobSearchRequest? jobSearchRequest,
    JobSource jobSource,
  ) async {
    try {
      final _baseUrl = jobSource.baseUrl();
      final webScraper = WebScraper(_baseUrl);
      final _searchString = jobSource.searchQuery(jobSearchRequest);
      log('URL').d('URL $_baseUrl$_searchString');
      if (await webScraper.loadWebPage(_searchString)) {
        final _document = webScraper.getPageContent();
        final _html = html.parse(_document);
        final _jobListElement = _html.querySelector('#mosaic-provider-jobcards > ul');
        final _jobListItems = _jobListElement?.children.where((element) => element.toString() == '<html li>') ?? [];

        for(var jobItem in _jobListItems){
          log('JOBS').d('JOB ${jobItem.innerHtml}');
          final title = jobItem.querySelector('a');
          log('JOBS').d('TITLE ${title?.innerHtml}');
        }

        return ApiResponse.completed(null);
      } else {
        log('ERROR').d('Failed to load page.');
        return ApiResponse.error('Failed to load page.');
      }
    } catch (e) {
      log('ERROR').d('Failed to load page.');
      return ApiResponse.error(e.toString());
    }
  }
}

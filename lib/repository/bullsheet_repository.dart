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
    final jobSources = jobSearchRequest?.jobSource;
    if (jobSources?.any((p0) => p0 == JobSource.totalJobs) == true) {
      _scrapeWebPage(jobSearchRequest, JobSource.totalJobs);
    }
    if (jobSources?.any((p0) => p0 == JobSource.indeed) == true) {
      _scrapeWebPage(jobSearchRequest, JobSource.indeed);
    }
    if (jobSources?.any((p0) => p0 == JobSource.youGov) == true) {
      _scrapeWebPage(jobSearchRequest, JobSource.youGov);
    }
    return ApiResponse.error('');
  }

  Future<ApiResponse> _scrapeWebPage(
    JobSearchRequest? jobSearchRequest,
    JobSource jobSource,
  ) async {
    try {
      final _baseUrl = jobSource.baseUrl();
      final _searchString = jobSource.searchQuery(jobSearchRequest);
      log('PAGE').d('URL $_baseUrl$_searchString');
      final webScraper = WebScraper(_baseUrl);
      if (await webScraper.loadWebPage(_searchString)) {
        //TODO scrape page of jobs
        log('PAGE').d('CONTENT ${webScraper.getPageContent()}');
        // final elements = webScraper.getElement('h3.title > a.caption', ['href']);
        // print(elements);
        return ApiResponse.completed(null);
      } else {
        return ApiResponse.error('Failed to load page.');
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}

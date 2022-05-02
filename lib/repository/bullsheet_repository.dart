import 'package:web_scraper/web_scraper.dart';

import '../api/models/extensions/job_source_extension.dart';
import '../api/models/job_search_request.dart';
import '../api/models/job_source.dart';

class BullsheetRepository {
  void scrapeJobSources(JobSearchRequest jobSearchRequest) {
    final jobSources = jobSearchRequest.jobSource;
    if (jobSources.any((p0) => p0 == JobSource.totalJobs)) {
      _scrapeWebPage(jobSearchRequest, JobSource.totalJobs);
    }
    if (jobSources.any((p0) => p0 == JobSource.indeed)) {
      _scrapeWebPage(jobSearchRequest, JobSource.indeed);
    }
    if (jobSources.any((p0) => p0 == JobSource.youGov)) {
      _scrapeWebPage(jobSearchRequest, JobSource.youGov);
    }
  }

  void _scrapeWebPage(
    JobSearchRequest jobSearchRequest,
    JobSource jobSource,
  ) async {
    try {
      final baseUrl = jobSource.baseUrl();
      final searchString = jobSource.searchQuery(jobSearchRequest);
      final webScraper = WebScraper(baseUrl);
      if (await webScraper.loadWebPage(searchString)) {
        //TODO scrape page of jobs
        final elements = webScraper.getElement('h3.title > a.caption', ['href']);
        print(elements);
      }
    } catch (e) {}
  }
}

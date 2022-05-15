import 'package:universal_html/html.dart';

extension ElementExtesnions on Element? {
  Element? indeedJobList() {
    return querySelector(
      '#mosaic-provider-jobcards > ul',
    );
  }

  Element? indeedTitleQuery() {
    return this?.querySelector(
      'div > div.slider_item > div > table.jobCard_mainContent.big6_visualChanges > tbody > tr > td > '
      'div.heading4.color-text-primary.singleLineTitle.tapItem-gutter > h2',
    );
  }

  Element? indeedCompanyQuery() {
    return this?.querySelector(
      'div.heading6.company_location.tapItem-gutter.companyInfo '
      '> span.companyName > a',
    );
  }

  Element? indeedUrlQuery() {
    return this?.querySelector(
      'div > div.slider_item > div > table.jobCard_mainContent.big6_visualChanges > tbody > tr > td > '
      'div.heading4.color-text-primary.singleLineTitle.tapItem-gutter > h2 > a',
    );
  }

  Element? indeedLocationQuery() {
    return this?.querySelector(
      'div.heading6.company_location.tapItem-gutter.companyInfo > div',
    );
  }
}

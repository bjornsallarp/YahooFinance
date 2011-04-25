# YahooFinance

The YahooFinance framework is an iOS Objective-C framework for Yahoo Finance.

## Features

- Search for stock symbols from major global stock exchanges [list](http://finance.yahoo.com/exchanges)
- Retrieve stock details such as quotes, volumes etc.
- Currency conversion for all major world currencies.

## Links

- [YahooFinance framework blogpost with video demonstration](http://blog.sallarp.com/yahoo-finance-api-for-ios/)
- [Yahoo! Finance](http://finance.yahoo.com)

## Dependency projects

- [ASIHTTPRequest](https://github.com/pokeb/asi-http-request)
- [JSON Framework](https://github.com/stig/json-framework)

## Install (iOS)

- Add ASIHTTPRequest to your project (see project specific details).
- Add JSON Framework to your project (see project specific details).
- Add the folder BSYahooFinance to your project.
- Include "BSYahooFinance.h" to use the features in YahooFinance.

## NOTE

The external components are submodules to the project. To get it running do the following:

1. Clone YahooFinance

2. Change directory to where you cloned YahooFinance, (cd YahooFinance)

3. Run the following commands:

- git submodule init

- git submodule update


Now you have the required components and the sample project will run as expected.

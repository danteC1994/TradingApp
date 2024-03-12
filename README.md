## Description
This is a simple app intended to show digital and Fiat Currency Trading informations.
This app will show you in a basic way the available exchange order books in the home View and data from a specified book in detailed view.

## Visuals

<img width="213" alt="Screenshot 2024-03-12 at 10 02 55" src="https://github.com/danteC1994/TradingApp/assets/116042202/00c49646-36ce-4ad3-8325-3fad162301b6">
<img width="211" alt="Screenshot 2024-03-12 at 14 07 18" src="https://github.com/danteC1994/TradingApp/assets/116042202/f2021e52-26af-45e4-a4e3-394a1d5c3ca3">
<img width="206" alt="Screenshot 2024-03-12 at 10 40 21" src="https://github.com/danteC1994/TradingApp/assets/116042202/6edee1b5-030d-4d69-a4cb-ce85ba661b0c">

## Installation

You will need to have Xcode installed with simulators that support iOS 16.
Also you need to have GIT.

_ Open an iTerm

_ Run git clone [https://github.com/danteC1994/TradingApp.git](https://github.com/danteC1994/TradingApp.git)

## Usage

### Run the app
To run the app you should only need to open the project, build and run

### Run app unit tests
To run all unit tests, tap cmd + U on your project. This will include the main TradingApp module tests as well as the Networking module ones

## Architecture
The App consists of two modules: Main Trading app and Networking module.

### Networking
Networking is meant to have all the structure needed to make API requests.
This is module tries to follow the open close principle and use encapsulation in order to be flexible enough to be used on different services with different RESTFUL methods, and allow scalling it by adding as many endpoints and services as needed. Also it keep their clients agnostic of the implementation by providing only an interface for using services and APIErrors

To avoid adding unncessary code, the package now just support GET requests:
<img width="793" alt="Screenshot 2024-03-12 at 13 45 07" src="https://github.com/danteC1994/TradingApp/assets/116042202/35f2c487-5f11-4f8a-aff1-9eaa6156f112">

The idea would be to create similar implementation for other RESTFUL methods, like POST,PUT,DELETE when needed.

### Main App
Architecture pattern: MVVM
Dependency manager: SPM

The architecture follows the MVVM basics. The app is sub-divided in features and each of them is supposed to have some different layers:
#### Views:
Contains all the views for the specific feature
#### ViewData:
Contains the data models used by views
These are models mapped from the APP domain Models
#### Services:
An interface used by the viewModel to connect with the Networking Module
#### ViewModels:
In charge of handling all the necessary logic to display UI data
map domain models into ViewData
handle UI states
connect with Networking layer through services

StatedViewModel:
The idea behind this interface is to encourage the creation of granular UI components that can have some different main states: IDLE, Loading, Error and Empty. This way developers will avoid creating very complex UI components with lot of different states and logic, instead, they will be "forcesd" to create sub-components that handles the basic states.

StatedViewModel interface:

<img width="410" alt="Screenshot 2024-03-12 at 14 02 31" src="https://github.com/danteC1994/TradingApp/assets/116042202/dcbb3b7b-d2b8-4301-94ed-073af471d3b0">

Implementation:
<img width="1045" alt="Screenshot 2024-03-12 at 14 03 30" src="https://github.com/danteC1994/TradingApp/assets/116042202/ab7183be-c31a-4f31-858a-19402286202b">

## Support

You can find more info aboout the API usage in [https://docs.bitso.com/bitso-api/docs/api-overview](https://docs.bitso.com/bitso-api/docs/api-overview)

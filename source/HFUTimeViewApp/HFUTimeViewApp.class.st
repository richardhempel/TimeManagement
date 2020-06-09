Class {
	#name : 'HFUTimeViewApp',
	#superclass : 'Application',
	#category : 'HFUTimeViewApp'
}

{ #category : 'Not categorized' }
HFUTimeViewApp class >> startUp [
	| theHttpServer |
	theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9033' serverApplicationClass: HFUTimeViewApp).
	theHttpServer addViewClass: HFUStampScanView.
	theHttpServer addViewClass: HFUStampSummaryView.
	HfuPerson createDefaultPersons.
	HfuPerson allPresentPeriods:  OrderedCollection new
]

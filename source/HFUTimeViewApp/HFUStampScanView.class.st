Class {
	#name : 'HFUStampScanView',
	#superclass : 'Me5BaseView',
	#category : 'HFUTimeViewApp'
}

{ #category : 'Not categorized' }
HFUStampScanView >> chipScanned [
|thePerson|
	HfuPerson chipScanned: '001'.
	thePerson := HfuPerson persons at: '001'.
	thePerson currentlyCheckedIn
	ifTrue: [
		self clockIn: thePerson]
	ifFalse: [self clockOut: thePerson].
	HfuPerson savePersons.
	HfuPerson savePresentPeriods.
]

{ #category : 'Not categorized' }
HFUStampScanView >> clockIn: anUser [
	|theUser theMessagePart1 theMessagePart2|
	theUser := anUser firstName asString. 
	theMessagePart1 := ' '.
	theMessagePart2 := ( 'hat sich erfolgreich angemeldet').
	self showSuccessNotificationWithTitle: theUser, theMessagePart1, theMessagePart2.
]

{ #category : 'Not categorized' }
HFUStampScanView >> clockOut: anUser [
	|theUser theMessagePart1 theMessagePart2|
	theUser := anUser firstName asString. 
	theMessagePart1 := ' '.
	theMessagePart2 := ( 'hat sich erfolgreich abgemeldet').
	self showDangerNotificationWithTitle: theUser, theMessagePart1, theMessagePart2.
]

{ #category : 'Initial-Events' }
HFUStampScanView >> createComponents [
	self	
			addChild: (Me5Portlet new
				addCssClassColLg3;
				addChildToBody: (Me5Div new
					addChild: (Me5Button newOutlineSuccess
						text: 'Simulate RFID Scan';
						addClickEventSelector: #chipScanned;
						yourself);
				yourself);
			yourself);
	yourself
			
						
]

Class {
	#name : 'HFUStampScanView',
	#superclass : 'Me5BaseView',
	#classVars : [
		'theContext',
		'thePortlet'
	],
	#category : 'HFUTimeViewApp'
}

{ #category : 'Not categorized' }
HFUStampScanView class >> clockIn: anUser [
	|theUser theMessagePart1 theMessagePart2|
	theUser := anUser firstName asString. 
	theMessagePart1 := ' '.
	theMessagePart2 := ( 'hat sich erfolgreich angemeldet').
	theContext showSuccessNotificationWithTitle: theUser, theMessagePart1, theMessagePart2.
]

{ #category : 'Not categorized' }
HFUStampScanView class >> clockOut: anUser [
	|theUser theMessagePart1 theMessagePart2|
	theUser := anUser firstName asString. 
	theMessagePart1 := ' '.
	theMessagePart2 := ( 'hat sich erfolgreich abgemeldet').
	theContext showDangerNotificationWithTitle: theUser, theMessagePart1, theMessagePart2.
]

{ #category : 'Not categorized' }
HFUStampScanView >> chipScanned [
	HfuPerson chipScanned: '001'.
]

{ #category : 'Not categorized' }
HFUStampScanView >> createComponents [
	theContext := self.
	self	
			addChild: (thePortlet := Me5Portlet new
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

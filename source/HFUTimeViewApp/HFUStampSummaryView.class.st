Class {
	#name : 'HFUStampSummaryView',
	#superclass : 'Me5BaseView',
	#classVars : [
		'theContext',
		'theTable',
		'the2ndPortlet',
		'thePortlet',
		'theUserTable'
	],
	#category : 'HFUTimeViewApp'
}

{ #category : 'Not categorized' }
HFUStampSummaryView >> createComponents [

theContext := self.
self
		addChild: (Me5FloatingIconOnlyButtonGroup new
			addChild: (Me5FloatingIconOnlyButton newSuccess
				icon: Me5I newFasRedo;
				addClickEventSelector: #updateTable;
			yourself);
		yourself);
		addChild: (thePortlet:= Me5Portlet new
			icon: Me5I newFasStamp;
			title: 'Übersicht';
			"addChildToHeadTools: (Me5A newIconOnlySuccess
					leftIcon: Me5I newFasRedo;
					setRoundStyle;
					addCssClassBtnSm;
					addClickEventSelector: #updateTable;
				yourself);"
			addChildToBody: (theTable := Me5Table new
				addChildToHead: (Me5TableRow new
						addTableHeaderWithText: 'ID';
						addTableHeaderWithText: 'Vorname';
						addTableHeaderWithText: 'Nachname';
						addTableHeaderWithText: 'Status';
						addTableHeaderWithText: 'Eingestempelt seit';
				yourself);
				setStripedStyle;
			yourself);
		yourself);
		updateTable;			
yourself.
]

{ #category : 'Not categorized' }
HFUStampSummaryView >> presentPeriodListNotEmpty: anPerson [
	anPerson presentPeriodList notEmpty
	ifTrue: [^anPerson presentPeriodList first stampIn asString ] ifFalse: [^'Kein Stempelvorgang aufgezeichnet']
	
]

{ #category : 'Not categorized' }
HFUStampSummaryView >> presentPeriodListNotEmptyIn: anPerson [
	anPerson presentPeriodList notEmpty
	ifTrue: [^anPerson presentPeriodList first stampIn asString] ifFalse: [^'Kein Einstempeln aufgezeichnet']
	
]

{ #category : 'Not categorized' }
HFUStampSummaryView >> presentPeriodListNotEmptyOut: anPerson [
	anPerson presentPeriodList notEmpty
	ifTrue: [^anPerson presentPeriodList first stampIn asString] ifFalse: [^anPerson presentPeriodList first stampOut asString]
	
]

{ #category : 'Not categorized' }
HFUStampSummaryView >> rowClicked: anEvent [
	|thePerson|
	"self showInfoNotificationWithMessage: ('%1 was clicked' bindWith: ((anEvent component children at: 1)text))."
	 "(anEvent component children at: 1)text."
	thePerson := HfuPerson persons at: ((anEvent component children at: 1)text).
	"self showInfoNotificationWithMessage: (thePerson firstName)."
	theContext removeChild: the2ndPortlet.
	theContext addChild: (the2ndPortlet := Me5Portlet new
		addChildToBody: (theUserTable := Me5Table new
				addChildToHead: (Me5TableRow new
						addTableHeaderWithText: ('Einstempelübersicht für: %1' bindWith: ( '%1 - Eingestempelt am:' bindWith:thePerson firstName));
				yourself);
				setStripedStyle;
			yourself);
	yourself).
	thePerson presentPeriodList do: [ :eachStamp | (theUserTable addChildToBody: (Me5TableRow new 
																																				addTableDataWithText: eachStamp stampIn;							
																																				yourself))
																																				].
	
	
]

{ #category : 'Not categorized' }
HFUStampSummaryView >> updateTable [
	|theClockedInPersons theClockedOutPersons|
	theTable removeAllChildrenFromBody.
	
	theClockedInPersons := HfuPerson persons select: [ :eachPersonClockedIn | (eachPersonClockedIn currentlyCheckedIn)].
	theClockedOutPersons := HfuPerson persons select: [ :eachPersonClockedIn | (eachPersonClockedIn currentlyCheckedIn not)].
	
	
	theClockedInPersons do: [ :eachPerson | (theTable addChildToBody: (Me5TableRow new 
																																				addTableDataWithText: eachPerson id;
																																				addTableDataWithText: eachPerson firstName;
																																				addTableDataWithText: eachPerson lastName;
																																				addTableDataWithChild: (Me5A newIconOnlySuccess
																																					leftIcon: Me5I newFasCheck;
																																					setRoundStyle);
																																				"addTableDataWithChild: (Me5Badge newThinSuccess);"
																																				addTableDataWithText: ((self presentPeriodListNotEmpty: eachPerson) asString);
																																				addClickEventSelector: #rowClicked:;
																																				yourself))
																																				].
																																				
	theClockedOutPersons do: [ :eachPerson | (theTable addChildToBody: (Me5TableRow new 
																																				addTableDataWithText: eachPerson id;
																																				addTableDataWithText: eachPerson firstName;
																																				addTableDataWithText: eachPerson lastName;
																																				addTableDataWithChild: (Me5A newIconOnlyDanger
																																					leftIcon: Me5I newFasBriefcase;
																																					setRoundStyle);
																																				"addTableDataWithChild: (Me5Badge newThinDanger);"
																																				addTableDataWithText: ((self presentPeriodListNotEmpty: eachPerson) asString);
																																				addClickEventSelector: #rowClicked:;
																																				yourself))
																																				].
]

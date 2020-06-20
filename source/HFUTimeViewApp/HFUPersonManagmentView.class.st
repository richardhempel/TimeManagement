Class {
	#name : 'HFUPersonManagmentView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'personTable'
	],
	#category : 'HFUTimeViewApp'
}

{ #category : 'Internal' }
HFUPersonManagmentView >> addEntryToPersonTable: aHfuPerson at: anID [
"adds an HfuPerson to the PersonTable"

	self personTable
		addChildToBody: (Me5TableRow new
			addTableDataWithText: anID;
			addTableDataWithText: aHfuPerson firstName;
			addTableDataWithText: aHfuPerson lastName;
			addChild: (Me5TableData new
				setAlignToRight;
				maxWidth: 50;
				addChild:(Me5A newIconOnlyPrimary
						icon: (Me5I newFasIdCard);
						yourself);
					addChild:(Me5A newIconOnlyPrimary
						icon: (Me5I newFasEdit);
						addClickEventSelector: #editEntryClicked:;
						yourself);
					addChild:(Me5A newIconOnlyDanger
						icon: (Me5I newFasTrash);
						addClickEventSelector: #removeEntryClicked:;
						yourself);
					yourself);
				yourself)
]

{ #category : 'Initial-Events' }
HFUPersonManagmentView >> createComponents [
"Creates the view"

	self
		addChild: (Me5Portlet new
			title: 'Personen';
			addChildToHeadTools: (Me5A newIconOnlySuccess
				icon: Me5I newFasUserPlus;
				addClickEventSelector: #createNewEntryClicked;
				yourself);
			addChildToBody: (personTable := Me5Table new
				setStripedStyle;
				addChildToHead: (Me5TableRow new
					addTableHeaderWithText: 'ID';
					addTableHeaderWithText: 'Vorname';
					addTableHeaderWithText: 'Nachname';
					yourself);
				yourself);	
			yourself);
		yourself.
		
		self personTableInitialization
]

{ #category : 'Events' }
HFUPersonManagmentView >> createNewEntryClicked [
	"Changes  the View to create a new Person"

	self replaceView: HFUPersonCreationView new
	"self openModal: HFUPersonFormModalView new"
]

{ #category : 'Events' }
HFUPersonManagmentView >> editEntryClicked: aClickedEvent [
"changes the View to a prefilled CreationView, that is only able to edit a Person"
	|aHFUPersonCreationView|
	aHFUPersonCreationView := HFUPersonCreationView new.
	self replaceView: aHFUPersonCreationView.
	aHFUPersonCreationView fillWith: 
			(HfuPerson persons at: ((aClickedEvent eventBoundComponent parent parent childAt: 1) componentText)).
	aHFUPersonCreationView blockIDTextField.
	aHFUPersonCreationView changeToEditView
	
]

{ #category : 'Accessing' }
HFUPersonManagmentView >> personTable [

	^personTable
]

{ #category : 'Accessing' }
HFUPersonManagmentView >> personTable: aTable [

	personTable := aTable
]

{ #category : 'Internal' }
HFUPersonManagmentView >> personTableInitialization [
"Initializes the Table with the HfuPersons containt in HfuPerson persons"
	
	HfuPerson persons keysDo: [:key| 
		self addEntryToPersonTable: (HfuPerson persons at: key) at: key]
]

{ #category : 'Events' }
HFUPersonManagmentView >> removeEntryClicked: aClickedEvent [

"Opens a Modal to confirm the deletion of the selected HfuPerson"
	
	self showYesNoDialogWithTitle: 
			'Person l&ouml;schen?' 
		message: 
			'M&ouml;chten sie die Person und alle dazugeh&ouml;rigen Daten unwiderruflich aus der Datenbank l&ouml;schen?' selector: #removeSelectorClicked:
]

{ #category : 'Internal' }
HFUPersonManagmentView >> removePersonFromDatabase: aMe5TableRow [
"Removes the HfuPerson from the Database and also removes the associated row from the personTable"

	HfuPerson persons removeKey: (aMe5TableRow childAt: 1) componentText ifAbsent: nil.
	aMe5TableRow removeComponent.
	HfuPerson savePersons.
]

{ #category : 'Events' }
HFUPersonManagmentView >> removeSelectorClicked: aClickedEvent [

"Calls the removePersonFromDatabase Methode if yes is selected"

	aClickedEvent answer
		ifTrue: [self removePersonFromDatabase: aClickedEvent originalComponent parent parent]
]

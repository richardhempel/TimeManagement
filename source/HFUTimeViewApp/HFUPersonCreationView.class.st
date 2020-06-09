Class {
	#name : 'HFUPersonCreationView',
	#superclass : 'Me5BaseView',
	#instVars : [
		'idTextField',
		'firstNameTextField',
		'lastNameTextField',
		'willCreateNewPerson'
	],
	#category : 'HFUTimeViewApp'
}

{ #category : 'Adjust' }
HFUPersonCreationView >> blockIDTextField [
	"disables the idTextField"
	self idTextField disable
]

{ #category : 'Adjust' }
HFUPersonCreationView >> changeToEditView [
	"sets the Create flag to false"
	self willCreateNewPerson: false
]

{ #category : 'Initial-Events' }
HFUPersonCreationView >> createComponents [
	"creates the view"
	self 
		addChild: (Me5FormPortlet new
			title: 'Person hinzuf�gen';
			addChildToBody: (Me5Section new
				addChildToBody: (Me5Row new
					addChild: (firstNameTextField:=Me5TextField new
						addCssClassCol12;
						addCssClassColSm6;
						text: 'Vorname';
						placeholder: 'Max...';
						leftOuterIcon: Me5I newFasUser;
						yourself);
					addChild: (lastNameTextField:=Me5TextField new
						addCssClassCol12;
						addCssClassColSm6;
						text: 'Nachname';
						placeholder: 'Mustermann...';
						leftOuterIcon: Me5I newFasUser;
						yourself);
					addChild: (idTextField:=Me5TextField new
						addCssClassCol12;
						addCssClassColSm6;
						text: 'ID';
						placeholder: '001...';
						leftOuterIcon: Me5I newFasIdBadge;
						yourself);
					yourself);
				yourself);
			addChildToFootButtonGroup: (Me5Button newPrimary
				icon: Me5I newFasSave;
				text: 'Speichern';
				addClickEventSelector: #saveChangesClicked;
				yourself);
			addChildToFootButtonGroup: (Me5Button newDanger
				icon: Me5I newFasBackspace;
				text: 'Verwerfen';
				addClickEventSelector: #discardChangesClicked;
				yourself);
			yourself);
		yourself.
		willCreateNewPerson:= true
	
]

{ #category : 'Events' }
HFUPersonCreationView >> discardChangesClicked [
	"Changes to the ManagementView"
	self replaceView: HFUPersonManagmentView new
]

{ #category : 'Internal' }
HFUPersonCreationView >> fillWith: aHfuPerson [
	"fills all the Textfields with the associated Data from the Person"
	self firstNameTextField value: aHfuPerson firstName.
	self lastNameTextField value: aHfuPerson lastName.
	self idTextField value: aHfuPerson id
]

{ #category : 'Accessing' }
HFUPersonCreationView >> firstNameTextField [

	^firstNameTextField
]

{ #category : 'Accessing' }
HFUPersonCreationView >> firstNameTextField: aTextField [

	firstNameTextField := aTextField
]

{ #category : 'Accessing' }
HFUPersonCreationView >> firstNameTextFieldValue [

	^firstNameTextField value
]

{ #category : 'Accessing' }
HFUPersonCreationView >> firstNameTextFieldValue: aString [

	firstNameTextField value: aString
]

{ #category : 'Internal' }
HFUPersonCreationView >> hasValidEntries [
	"Checks all Textfields whether or not they are acceptet by HfuPerson and turns the accepted white and the other red"
	|theResult|
	theResult := true.
	(HfuPerson isValidName: (self firstNameTextFieldValue)) 
		ifTrue: [self firstNameTextField 
			setSuccessStyle;
			leftOuterIcon: Me5I newFasUser setSuccessFontStyle;
			yourself]
		ifFalse: [self firstNameTextField 
			setDangerStyle; "dangerText: "
			leftOuterIcon: Me5I newFasUser setDangerFontStyle;
			yourself.
			theResult := false].
	(HfuPerson isValidName: (self lastNameTextFieldValue)) 
		ifTrue: [self lastNameTextField 
			setSuccessStyle;
			leftOuterIcon: Me5I newFasUser setSuccessFontStyle;
			yourself]
		ifFalse: [self lastNameTextField 
			setDangerStyle; "dangerText: "
			leftOuterIcon: Me5I newFasUser setDangerFontStyle.
			theResult := false].
	(HfuPerson isValidID: (self idTextFieldValue)) 
		ifTrue: [self idTextField  
			setSuccessStyle;
			leftOuterIcon: Me5I newFasIdBadge setSuccessFontStyle;
			yourself]
		ifFalse: [self firstNameTextField 
			setDangerStyle; "dangerText: "
			leftOuterIcon: Me5I newFasIdBadge setDangerFontStyle.
			theResult := false].
	^theResult
]

{ #category : 'Accessing' }
HFUPersonCreationView >> idTextField [

	^idTextField
]

{ #category : 'Accessing' }
HFUPersonCreationView >> idTextField: aTextField [

	idTextField := aTextField
]

{ #category : 'Accessing' }
HFUPersonCreationView >> idTextFieldValue [

	^idTextField value
]

{ #category : 'Accessing' }
HFUPersonCreationView >> idTextFieldValue: aString [

	idTextField value: aString
]

{ #category : 'Accessing' }
HFUPersonCreationView >> lastNameTextField [

	^lastNameTextField
]

{ #category : 'Accessing' }
HFUPersonCreationView >> lastNameTextField: aTextField [

	lastNameTextField := aTextField
]

{ #category : 'Accessing' }
HFUPersonCreationView >> lastNameTextFieldValue [

	^lastNameTextField value
]

{ #category : 'Accessing' }
HFUPersonCreationView >> lastNameTextFieldValue: aString [

	lastNameTextField value: aString
]

{ #category : 'Events' }
HFUPersonCreationView >> saveChangesClicked [
	"Saves the changes and changes to the ManagementView, when all the entries are valid. If not remains in this view"
	|thePerson|
	self hasValidEntries "also turns inValid Entries red"
		ifTrue: [
			self willCreateNewPerson
				ifTrue: [thePerson := HfuPerson new 
					presentPeriodList: OrderedCollection new; currentlyCheckedIn: false; yourself] 
				ifFalse: [thePerson := HfuPerson persons at:(self idTextFieldValue)].
			thePerson firstName: (self firstNameTextFieldValue);lastName:(self lastNameTextFieldValue);id:(self idTextFieldValue) yourself.
			HfuPerson persons at:(self idTextFieldValue) put: thePerson.
			self replaceView: HFUPersonManagmentView new]
]

{ #category : 'Accessing' }
HFUPersonCreationView >> willCreateNewPerson [
	^willCreateNewPerson
]

{ #category : 'Accessing' }
HFUPersonCreationView >> willCreateNewPerson: aBoolean [
	willCreateNewPerson := aBoolean
]

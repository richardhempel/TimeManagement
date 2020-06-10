Class {
	#name : 'HfuPerson',
	#superclass : 'Object',
	#instVars : [
		'lastName',
		'firstName',
		'presentPeriodList',
		'currentlyCheckedIn',
		'id'
	],
	#classVars : [
		'Persons',
		'AllPresentPeriods'
	],
	#category : 'HfuTimeManagementModelApp'
}

{ #category : 'Accessor' }
HfuPerson class >> allPresentPeriods [

	^AllPresentPeriods
]

{ #category : 'Accessor' }
HfuPerson class >> allPresentPeriods: anObject [

	AllPresentPeriods := anObject
]

{ #category : 'Not categorized' }
HfuPerson class >> chipScanned: anIdetification [
"Creates a new Stamp for the Person with the matching identification
	 and inverts the status of currentlyCheckedIn"
	| thePerson thePresentPeriod |
	thePerson := self persons at: anIdetification.
	thePerson currentlyCheckedIn = false
		ifTrue: [thePresentPeriod := HfuPresentPeriod new.
					thePresentPeriod stampIn: DateAndTime now.
					thePerson presentPeriodList  addFirst: thePresentPeriod.
					self allPresentPeriods addFirst: thePresentPeriod.
					thePerson currentlyCheckedIn: true.] 
		ifFalse: [thePerson presentPeriodList first stampOut: DateAndTime now.
					thePerson currentlyCheckedIn: false]
]

{ #category : 'Not categorized' }
HfuPerson class >> copyFile [
	"Copies contents of id.txt into cache.txt and erases id.txt. 
	 Returns true if file is not empty."
	| theFile theFileCopy |
	theFile := CfsReadWriteFileStream open: 'id.txt'.
	theFileCopy := CfsReadWriteFileStream openEmpty: 'cache.txt'.
	theFileCopy nextPutAll: theFile contents.
	theFileCopy flush.
	theFileCopy close.
	CfsReadWriteFileStream openEmpty: 'id.txt'.
	theFile close.
	^theFileCopy isEmpty not.
	
]

{ #category : 'Not categorized' }
HfuPerson class >> createDefaultPersons [
	"Creates default Persons used for tests"
	| theDefaultPerson1 theDefaultPerson2 theDefaultPerson3 theDefaultPerson4 theDefaultPerson5 |

	theDefaultPerson1 := HfuPerson new.
	theDefaultPerson1  lastName: 'Omar'; firstName: 'Saleh';  id: '001'; presentPeriodList: OrderedCollection new; currentlyCheckedIn: false; yourself.
	theDefaultPerson2 := HfuPerson new.
	theDefaultPerson2  lastName: 'Weinberger'; firstName: 'Tom'; id: '002'; presentPeriodList: OrderedCollection new; currentlyCheckedIn: false; yourself.
	theDefaultPerson3 := HfuPerson new.
	theDefaultPerson3  lastName: 'Bochyn'; firstName: 'Pascal';id: '003'; presentPeriodList: OrderedCollection new; currentlyCheckedIn: false; yourself.
	theDefaultPerson4 := HfuPerson new.
	theDefaultPerson4  lastName: 'Hempel'; firstName: 'Richard';id: '004'; presentPeriodList: OrderedCollection new; currentlyCheckedIn: false; yourself.
	theDefaultPerson5 := HfuPerson new.
	theDefaultPerson5  lastName: 'Petrov'; firstName: 'Anton';id: '005'; presentPeriodList: OrderedCollection new; currentlyCheckedIn: false; yourself.

	self persons: Dictionary new.
	self persons at: '001' put: theDefaultPerson1.
	self persons at: '002' put: theDefaultPerson2.
	self persons at: '003' put: theDefaultPerson3.
	self persons at: '004' put: theDefaultPerson4.
	self persons at: '005' put: theDefaultPerson5
]

{ #category : 'Not categorized' }
HfuPerson class >> isValidID: aString [
"Determines whether or not aString is a valid ID"

	|theResult|
	theResult := true.
	aString do: [ :eachChar | 
		eachChar isDigit
			ifFalse: [theResult := false]].
	^theResult
]

{ #category : 'Not categorized' }
HfuPerson class >> isValidName: aString [
"Determines whether or not aString is a valid Name"

	|theResult|
	theResult := true.
	aString do: [ :eachChar | 
		eachChar isLetter
			ifFalse: [theResult := false]].
	^theResult
	
]

{ #category : 'Accessor' }
HfuPerson class >> persons [

	^Persons
]

{ #category : 'Accessor' }
HfuPerson class >> persons: anObject [

	Persons := anObject
]

{ #category : 'Not categorized' }
HfuPerson class >> readFile [
	"If the file isn't empty the id is given to chipScanned:"
	| theDelay |
	theDelay := Delay forSeconds: 5.
	1 to: 5 do: [:i |
		[
			| theFile |
			self copyFile
			ifTrue: [
				theFile := CfsReadWriteFileStream open: 'cache.txt'.
				self chipScanned: theFile contents.
			]
		] fork.
		theDelay wait.
	]
	
	
]

{ #category : 'Accessor' }
HfuPerson >> currentlyCheckedIn [

	^currentlyCheckedIn
]

{ #category : 'Accessor' }
HfuPerson >> currentlyCheckedIn: anObject [

	currentlyCheckedIn := anObject
]

{ #category : 'Accessor' }
HfuPerson >> firstName [

	^firstName
]

{ #category : 'Accessor' }
HfuPerson >> firstName: anObject [

	firstName := anObject
]

{ #category : 'Accessor' }
HfuPerson >> id [

	^id
]

{ #category : 'Accessor' }
HfuPerson >> id: anObject [

	id := anObject
]

{ #category : 'Accessor' }
HfuPerson >> lastName [

	^lastName
]

{ #category : 'Accessor' }
HfuPerson >> lastName: anObject [

	lastName := anObject
]

{ #category : 'Accessor' }
HfuPerson >> presentPeriodList [

	^presentPeriodList
]

{ #category : 'Accessor' }
HfuPerson >> presentPeriodList: anObject [

	presentPeriodList := anObject
]

{ #category : 'Not categorized' }
HfuPerson >> timeCheckedInDay: aDay month: aMonth year: aYear [
	"Returns the total time checked in on the specified day for this person instance"
	| theBuffer |
	theBuffer := Duration new.
	theBuffer totalSeconds: 0 microseconds: 0.
	self presentPeriodList do: [:eachPeriod | | theTimeCheckedIn |
												theTimeCheckedIn := (eachPeriod stampOut - eachPeriod stampIn).
												(eachPeriod stampIn dayOfMonth = aDay and: (eachPeriod stampIn monthIndex = aMonth and: eachPeriod stampIn year = aYear))
												ifTrue: [theBuffer := theBuffer + theTimeCheckedIn]].
	^theBuffer
]

{ #category : 'Not categorized' }
HfuPerson >> timeCheckedInMonth: aMonth year: aYear [
	"Returns the total time checked in on the specified month for this person instance"
	| theBuffer |
	theBuffer := Duration new.
	theBuffer totalSeconds: 0 microseconds: 0.
	self presentPeriodList do: [:eachPeriod | | theTimeCheckedIn |
												theTimeCheckedIn := (eachPeriod stampOut - eachPeriod stampIn).
												(eachPeriod stampIn monthIndex = aMonth and: eachPeriod stampIn year = aYear)
												ifTrue: [theBuffer := theBuffer + theTimeCheckedIn]].
	^theBuffer
]

{ #category : 'Not categorized' }
HfuPerson >> timeCheckedInTotal [
	"Returns the total time checked in for this person instance"
	| theBuffer |
	theBuffer := Duration new.
	theBuffer totalSeconds: 0 microseconds: 0.
	self presentPeriodList do: [:eachPeriod | | theTimeCheckedIn |
												theTimeCheckedIn := (eachPeriod stampOut - eachPeriod stampIn).
												theBuffer := theBuffer + theTimeCheckedIn].
	^theBuffer
]

{ #category : 'Not categorized' }
HfuPerson >> timeCheckedInYear: aYear [
	"Returns the total time checked in on the specified year for this person instance"
	| theBuffer |
	theBuffer := Duration new.
	theBuffer totalSeconds: 0 microseconds: 0.
	self presentPeriodList do: [:eachPeriod | | theTimeCheckedIn |
												theTimeCheckedIn := (eachPeriod stampOut - eachPeriod stampIn).
												(eachPeriod stampIn year = aYear)
												ifTrue: [theBuffer := theBuffer + theTimeCheckedIn]].
	^theBuffer
]

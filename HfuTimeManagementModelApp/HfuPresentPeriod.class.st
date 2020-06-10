Class {
	#name : 'HfuPresentPeriod',
	#superclass : 'Object',
	#instVars : [
		'stampIn',
		'stampOut'
	],
	#category : 'HfuTimeManagementModelApp'
}

{ #category : 'Accessor' }
HfuPresentPeriod >> stampIn [

	^stampIn
]

{ #category : 'Accessor' }
HfuPresentPeriod >> stampIn: anObject [

	stampIn := anObject
]

{ #category : 'Accessor' }
HfuPresentPeriod >> stampOut [

	^stampOut
]

{ #category : 'Accessor' }
HfuPresentPeriod >> stampOut: anObject [

	stampOut := anObject
]

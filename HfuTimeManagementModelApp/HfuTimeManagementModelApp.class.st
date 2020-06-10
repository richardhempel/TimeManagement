Class {
	#name : 'HfuTimeManagementModelApp',
	#superclass : 'Application',
	#category : 'HfuTimeManagementModelApp'
}

{ #category : 'Not categorized' }
HfuTimeManagementModelApp class >> startUp [
	HfuPerson readFile.
]

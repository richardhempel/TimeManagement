Class {
	#name : 'HFUTimeViewApp',
	#superclass : 'Application',
	#category : 'HFUTimeViewApp'
}

{ #category : 'Not categorized' }
HFUTimeViewApp class >> startUp [

|theHttpServer|
theHttpServer := (Me5SstHttpServer startUpHttpServerOnPort: '9004' serverApplicationClass: HFUTimeViewApp).
theHttpServer addViewClass: HFUPersonManagmentView.
theHttpServer addViewClass: HFUPersonCreationView 

]

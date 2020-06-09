Class {
	#name : 'HFUPersonFormModalView',
	#superclass : 'Me5BaseDialogModalView',
	#category : 'HFUTimeViewApp'
}

{ #category : 'Initial-Events' }
HFUPersonFormModalView >> createComponents [

	super createComponents.
	self modal
		title: 'Person bearbeiten';
		addChildToBody:(Me5Form new
			addChildToBody:(Me5TextField new
				text: 'ID';
				yourself);
			addChildToBody:(Me5TextField new
				text: 'Vorname';
				yourself);
			addChildToBody:(Me5TextField new
				text: 'Nachname';
				yourself);
			yourself);
		addChildToFoot: (Me5DialogButtonGroup new
			addMobileButton: (self createYesButton
				addClickEventSelector: #performSelectorWithEvent:; 
				yourself);
			addMobileButton: (self createCancelButton
				addClickEventSelector: #performSelectorWithEvent:; 
				yourself);
		yourself)
]

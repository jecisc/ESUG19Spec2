Class {
	#name : #ESUG2BrowseLocationCommand,
	#superclass : #ESUG2Command,
	#category : #'ESUG2019-Completed-ESUG2019-Completed'
}

{ #category : #converting }
ESUG2BrowseLocationCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallFind;
		yourself
]

{ #category : #executing }
ESUG2BrowseLocationCommand >> execute [
	self selectedMethod browse
]

{ #category : #initialization }
ESUG2BrowseLocationCommand >> initialize [
	super initialize.
	self
		basicName: 'Browse location'; 
		basicDescription: 'I browse a flag location'
]

Class {
	#name : #ESUGBrowseLocationCommand,
	#superclass : #CmCommand,
	#category : #ESUG2019
}

{ #category : #converting }
ESUGBrowseLocationCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallFind;
		yourself
]

{ #category : #executing }
ESUGBrowseLocationCommand >> execute [
	self context locations selectedItem compiledMethod browse
]

{ #category : #initialization }
ESUGBrowseLocationCommand >> initialize [
	super initialize.
	self
		basicName: 'Browse location'; 
		basicDescription: 'I browse a flag location'
]

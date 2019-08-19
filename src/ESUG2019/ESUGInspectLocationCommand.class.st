Class {
	#name : #ESUGInspectLocationCommand,
	#superclass : #CmCommand,
	#category : #ESUG2019
}

{ #category : #converting }
ESUGInspectLocationCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallInspectIt;
		yourself
]

{ #category : #executing }
ESUGInspectLocationCommand >> execute [
	self context locations selectedItem compiledMethod inspect
]

{ #category : #initialization }
ESUGInspectLocationCommand >> initialize [
	super initialize.
	self
		basicName: 'Inspect location'; 
		basicDescription: 'I inspect a flag location'
]

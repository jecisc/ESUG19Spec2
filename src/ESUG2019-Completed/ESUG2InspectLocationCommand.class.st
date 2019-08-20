Class {
	#name : #ESUG2InspectLocationCommand,
	#superclass : #CmCommand,
	#category : #'ESUG2019-Completed-ESUG2019-Completed'
}

{ #category : #converting }
ESUG2InspectLocationCommand >> asSpecCommand [
	^ super asSpecCommand
		iconName: #smallInspectIt;
		yourself
]

{ #category : #executing }
ESUG2InspectLocationCommand >> execute [
	self context locations selectedItem compiledMethod inspect
]

{ #category : #initialization }
ESUG2InspectLocationCommand >> initialize [
	super initialize.
	self
		basicName: 'Inspect location'; 
		basicDescription: 'I inspect a flag location'
]

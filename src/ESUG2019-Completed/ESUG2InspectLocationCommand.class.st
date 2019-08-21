Class {
	#name : #ESUG2InspectLocationCommand,
	#superclass : #ESUG2Command,
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
	self selectedMethod inspect
]

{ #category : #initialization }
ESUG2InspectLocationCommand >> initialize [
	super initialize.
	self
		name: 'Inspect location'; 
		description: 'I inspect a flag location'
]

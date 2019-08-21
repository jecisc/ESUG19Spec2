Class {
	#name : #ESUG2Command,
	#superclass : #CmCommand,
	#category : #'ESUG2019-Completed-ESUG2019-Completed'
}

{ #category : #testing }
ESUG2Command >> canBeExecuted [
	^ self context selectedLocation isNotNil
]

{ #category : #executing }
ESUG2Command >> selectedMethod [
	^ self context selectedLocation compiledMethod
]

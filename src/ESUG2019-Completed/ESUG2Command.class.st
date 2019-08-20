Class {
	#name : #ESUG2Command,
	#superclass : #CmCommand,
	#category : #'ESUG2019-Completed-ESUG2019-Completed'
}

{ #category : #executing }
ESUG2Command >> selectedMethod [
	^ self context selectedLocation compiledMethod
]

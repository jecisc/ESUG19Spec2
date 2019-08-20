Extension { #name : #FBFlag }

{ #category : #'*ESUG2019-Completed' }
FBFlag >> infos [
	^ 'Flag: {1}
Number of locations: {2}' format: {parameter . locations size}
]

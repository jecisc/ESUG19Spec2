Class {
	#name : #ESUGFlagBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'#flags',
		'#locations',
		'#code',
		'#caseSensitive => SpObservableSlot'
	],
	#category : #ESUG2019
}

{ #category : #commands }
ESUGFlagBrowser class >> buildCommandsGroupWith: presenterIntance forRoot: rootCommandGroup [
	rootCommandGroup
		register:
			((CmCommandGroup named: 'Menu') asSpecGroup
				register: ESUGBrowseLocationCommand forSpec;
				register: ESUGInspectLocationCommand forSpec;
				yourself);
		register:
			((CmCommandGroup named: 'Toolbar') asSpecGroup
				register:
					(ESUGBrowseLocationCommand forSpec
						basicName: 'Browse';
						yourself);
				yourself)
]

{ #category : #specs }
ESUGFlagBrowser class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		position: 30 percent;
		add:
			(SpBoxLayout newVertical
				add: 'Flags' height: self labelHeight;
				add: #flags;
				yourself);
		add:
			(SpPanedLayout newVertical
				add: #locations;
				add: #code;
				yourself);
		yourself
]

{ #category : #accessing }
ESUGFlagBrowser >> caseSensitive: aBoolean [
	caseSensitive := aBoolean
]

{ #category : #accessing }
ESUGFlagBrowser >> code [
	^ code
]

{ #category : #accessing }
ESUGFlagBrowser >> code: anObject [
	code := anObject
]

{ #category : #accessing }
ESUGFlagBrowser >> flags [
	^ flags
]

{ #category : #accessing }
ESUGFlagBrowser >> flags: anObject [
	flags := anObject
]

{ #category : #initialization }
ESUGFlagBrowser >> initialize [
	super initialize.
	caseSensitive := false
]

{ #category : #initialization }
ESUGFlagBrowser >> initializePresenter [
	locations
		transmitTo: code
		transform: [ :location | location sourceCode ]
		postTransmission: [ :destination :origin :location | 
			destination
				behavior: location classLocation;
				setSelection: location interval ].
	self flag: #A.
	self flag: #a.
	flags
		transmitTo: locations
		transform: [ :flag | flag locations ]
		postTransmission: [ :destination :origin :flag |
			destination selectIndex: 1 ].

	flags selectIndex: 1.
	
	self property: #caseSensitive whenChangedDo: [ :bool | FBFlag caseSensitive: bool. flags items: FBSymbolFlag allFlags ]
]

{ #category : #initialization }
ESUGFlagBrowser >> initializeWidgets [
	locations := self newTable.
	code := self newCode.
	flags := self newList.

	flags
		display: [ :flag | flag parameter ];
		items: FBSymbolFlag allFlags;
		sortingBlock: #parameter ascending.

	locations
		addColumn: (SpStringTableColumn title: 'Class' evaluated: [ :location | location classLocation ]);
		addColumn: (SpStringTableColumn title: 'Method' evaluated: [ :location | location selector ]);
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Menu' ];
		yourself
]

{ #category : #initialization }
ESUGFlagBrowser >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Flag browser';
		initialExtent: 800 @ 600.
	aWindowPresenter toolBar: (self rootCommandsGroup / 'Toolbar') asToolBarPresenter
]

{ #category : #accessing }
ESUGFlagBrowser >> locations [
	^ locations
]

{ #category : #accessing }
ESUGFlagBrowser >> locations: anObject [
	locations := anObject
]

{ #category : #enumerating }
ESUGFlagBrowser >> whenFlagChangedDo: aBlock [
	flags whenSelectionChangedDo: [ :selection | aBlock value: selection selectedItem ]
]

Class {
	#name : #ESUG2FlagBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'#flags',
		'#locations',
		'#code',
		'#caseSensitive => SpObservableSlot',
		'#notebook'
	],
	#category : #'ESUG2019-Completed-ESUG2019-Completed'
}

{ #category : #commands }
ESUG2FlagBrowser class >> buildCommandsGroupWith: presenterIntance forRoot: rootCommandGroup [
	rootCommandGroup
		register:
			((CmCommandGroup named: 'Menu') asSpecGroup
				register: ESUG2BrowseLocationCommand forSpec;
				register: ESUG2InspectLocationCommand forSpec;
				yourself);
		register:
			((CmCommandGroup named: 'Toolbar') asSpecGroup
				register:
					(ESUG2BrowseLocationCommand forSpec
						basicName: 'Browse';
						yourself);
				yourself)
]

{ #category : #specs }
ESUG2FlagBrowser class >> defaultSpec [
	^ SpPanedLayout newHorizontal
		position: 30 percent;
		add:
			(SpBoxLayout newVertical
				add: 'Flags' expand: false fill: false padding: 0;
				add: #flags;
				yourself);
		add:
			(SpPanedLayout newVertical
				add: #locations;
				add: #notebook;
				yourself);
		yourself
]

{ #category : #accessing }
ESUG2FlagBrowser class >> openPlayground [
	<script>
	GTPlayground openContents: 'p := ESUGFlagBrowser new.
p openWithSpec.

p caseSensitive: true.
p caseSensitive: false.'
]

{ #category : #accessing }
ESUG2FlagBrowser >> caseSensitive: aBoolean [
	caseSensitive := aBoolean
]

{ #category : #initialization }
ESUG2FlagBrowser >> connectPresenters [
	locations
		transmitTo: code
		transform: [ :location | location sourceCode ]
		postTransmission: [ :destination :origin :location | 
			destination
				behavior: location classLocation;
				setSelection: location interval ].

	flags transmitTo: locations transform: [ :flag | flag locations ] postTransmission: [ :destination :origin :flag | destination selectIndex: 1 ].
	flags whenSelectionChangedDo: [ :selection | self withWindowDo: [ :w | w title: self title ] ].

	flags selectIndex: 1.

	self
		property: #caseSensitive
		whenChangedDo: [ :bool | 
			FBFlag caseSensitive: bool.
			flags items: FBSymbolFlag allFlags ]
]

{ #category : #initialization }
ESUG2FlagBrowser >> initialize [
	super initialize.
	caseSensitive := false.
	
	self flag: #A.
	self flag: #a
]

{ #category : #initialization }
ESUG2FlagBrowser >> initializePresenters [
	locations := self newTable.
	code := self newCode.
	flags := self newList.
	notebook := self newNotebook.

	flags
		display: [ :flag | flag parameter ];
		items: FBSymbolFlag allFlags;
		sortingBlock: #parameter ascending.

	locations
		addColumn: (SpStringTableColumn title: 'Class' evaluated: [ :location | location classLocation ]);
		addColumn: (SpStringTableColumn title: 'Method' evaluated: [ :location | location selector ]);
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Menu' ].

	notebook
		addPage: (SpNotebookPage title: 'Code' icon: (self iconNamed: #changeUpdate) provider: [ code ]);
		addPage: (SpNotebookPage title: 'Infos' icon: (self iconNamed: #add) provider: [
			SpTextPresenter new
				text: self selectedFlag;
				yourself ])
]

{ #category : #initialization }
ESUG2FlagBrowser >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: 'Flag browser';
		initialExtent: 800 @ 600.
	aWindowPresenter toolBar: (self rootCommandsGroup / 'Toolbar') asToolBarPresenter
]

{ #category : #accessing }
ESUG2FlagBrowser >> selectedFlag [
	^ flags selectedItem
]

{ #category : #accessing }
ESUG2FlagBrowser >> selectedLocation [
	^ locations selectedItem
]

{ #category : #initialization }
ESUG2FlagBrowser >> title [
	^ 'Flag browser - ' , self selectedFlag parameter
]

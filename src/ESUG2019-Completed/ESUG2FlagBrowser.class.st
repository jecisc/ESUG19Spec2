Class {
	#name : #ESUG2FlagBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'#flags',
		'#locations',
		'#code',
		'#caseSensitive => SpObservableSlot'
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
						name: 'Browse';
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
				add: #code;
				yourself);
		yourself
]

{ #category : #'instance creation' }
ESUG2FlagBrowser class >> open [
	<script>
	self new openWithSpec
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
	flags
		transmitTo: locations
		transform: [ :flag | flag locations ]
		postTransmission: [ :destination :origin :flag | destination selectIndex: 1 ].

	locations
		transmitTo: code
		transform: [ :location | location sourceCode ]
		postTransmission: [ :destination :origin :location | 
			destination
				behavior: location classLocation;
				setSelection: location interval ].

	flags whenSelectionChangedDo: [ :selection | self withWindowDo: [ :w | w title: self title ] ].

	self
		property: #caseSensitive
		whenChangedDo: [ :bool | 
			FBFlag caseSensitive: bool.
			flags
				items: FBSymbolFlag allFlags;
				selectIndex: 1 ].

	caseSensitive := false.
]

{ #category : #initialization }
ESUG2FlagBrowser >> initializePresenters [
	locations := self newTable.
	code := self newCode.
	flags := self newList.

	flags
		display: [ :flag | flag parameter ];
		sortingBlock: #parameter ascending.

	locations
		addColumn: (SpStringTableColumn title: 'Class' evaluated: [ :location | location classLocation ]);
		addColumn: (SpStringTableColumn title: 'Method' evaluated: [ :location | location selector ]);
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Menu' ]
]

{ #category : #initialization }
ESUG2FlagBrowser >> initializeWindow: aWindowPresenter [
	aWindowPresenter
		title: self title;
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
	self flag: #A.
	self flag: #a.
	^ 'Flag browser - ' , self selectedFlag parameter
]

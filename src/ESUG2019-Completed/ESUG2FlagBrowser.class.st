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
				add: 'Flags' height: self labelHeight;
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

p caseSensitive: true'
]

{ #category : #accessing }
ESUG2FlagBrowser >> caseSensitive: aBoolean [
	caseSensitive := aBoolean
]

{ #category : #accessing }
ESUG2FlagBrowser >> code [
	^ code
]

{ #category : #accessing }
ESUG2FlagBrowser >> code: anObject [
	code := anObject
]

{ #category : #accessing }
ESUG2FlagBrowser >> flags [
	^ flags
]

{ #category : #accessing }
ESUG2FlagBrowser >> flags: anObject [
	flags := anObject
]

{ #category : #initialization }
ESUG2FlagBrowser >> initialize [
	super initialize.
	caseSensitive := false
]

{ #category : #initialization }
ESUG2FlagBrowser >> initializePresenter [
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
ESUG2FlagBrowser >> initializeWidgets [
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
		contextMenuFromCommandsGroup: [ self rootCommandsGroup / 'Menu' ];
		yourself.

	notebook
		addPage: (SpNotebookPage title: 'Code' icon: (self iconNamed:#changeUpdate) provider: [ code ]);
		addPage:
			(SpNotebookPage
				title: 'Infos'
				icon:  (self iconNamed:#add)
				provider: [ SpTextPresenter new
						text:
							('Flag: {1}
Number of locations: {2}' format: {self flags selectedItem parameter . self flags selectedItem locations size});
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
ESUG2FlagBrowser >> locations [
	^ locations
]

{ #category : #accessing }
ESUG2FlagBrowser >> locations: anObject [
	locations := anObject
]

{ #category : #enumerating }
ESUG2FlagBrowser >> whenFlagChangedDo: aBlock [
	flags whenSelectionChangedDo: [ :selection | aBlock value: selection selectedItem ]
]

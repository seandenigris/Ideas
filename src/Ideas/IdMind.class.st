Class {
	#name : 'IdMind',
	#superclass : 'Object',
	#instVars : [
		'ideas',
		'links',
		'uuid',
		'userEmailString',
		'lepiterDatabase'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : 'Ideas'
}

{ #category : 'accessing' }
IdMind class >> example [
	^ self 
		given: [ IdMind new ]
		when: [ :m |
			m 
				addIdea: IdIdea example;
				addIdea: IdConcept example;
				yourself ]
		then: [ :m | m ideas should haveSize: 2 ]
]

{ #category : 'persistence' }
IdMind class >> restoreFrom: anObject [

	UniqueInstance := anObject.
]

{ #category : 'persistence' }
IdMind class >> spData [

	^ UniqueInstance.
]

{ #category : 'accessing' }
IdMind class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : 'accessing' }
IdMind class >> uniqueInstance: anIdMind [
	UniqueInstance := anIdMind
]

{ #category : 'DB' }
IdMind >> addExplicitLink: aLink [
	aLink onAboutToAddToDatabase: self.
	self links addLink: aLink.
	aLink onAddedToDatabase: self.
]

{ #category : 'DB' }
IdMind >> addExplicitLinks: aCollectionOfExplicitLinks [
	self assert: [ aCollectionOfExplicitLinks notNil ].
	
	aCollectionOfExplicitLinks do: [ :eachLink | 
		self addExplicitLink: eachLink ]
]

{ #category : 'accessing' }
IdMind >> addIdea: anIdea [
	anIdea mind: self.
	(self lepiterDatabase children includes: anIdea lepiterPage)
		ifFalse: [ self lepiterDatabase addPage: anIdea lepiterPage ].
	self ideas add: anIdea
]

{ #category : 'DB' }
IdMind >> cachedLinksForContent: aSnippet [
	^ self links select: [ :e | e origin = aSnippet ]
]

{ #category : 'accessing' }
IdMind >> gtGtSpotterFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'Ideas';
		allCandidates: [ self ideas ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
		itemName: #displayString
]

{ #category : 'accessing' }
IdMind >> gtSpotterNewIdeaFor: aStep [
	<gtSearch>
	aStep listProcessor
		title: 'New Idea';
		priority: 50;
		itemName: [ :input | 'Create new idea: ', input ];
		previewObject: [ :input | IdIdea fromString: input ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self ideas anySatisfy: [ :e | 
					e markdownString = context textTrimmed ].
				isExisting ifFalse: [ 
					filter value: context textTrimmed ] ];
		send: [ :input :spotterStep | 
			| instance |
			instance := IdIdea fromString: input.
			self ideas add: instance ]
]

{ #category : 'accessing' }
IdMind >> gtSpotterNewWorkFor: aStep [
	<gtSearch>
	aStep listProcessor
		title: 'New Idea';
		priority: 50;
		itemName: [ :input | 'Create new idea: ', input ];
		previewObject: [ :input | IdIdea fromString: input ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter
			item: [ :filter :context | 
				| isExisting |
				isExisting := self ideas anySatisfy: [ :e | 
					e markdownString = context textTrimmed ].
				isExisting ifFalse: [ 
					filter value: context textTrimmed ] ];
		send: [ :input :spotterStep | 
			| instance |
			instance := IdIdea fromString: input.
			self addIdea: instance ]
]

{ #category : 'accessing' }
IdMind >> gtViewIdeasOn: aView [
	<gtView>
	^ aView list
		title: 'Ideas' translated;
		priority: 8;
		items: [ self ideas asOrderedCollection ];
		itemText: [ :e | e markdownString asRopedText ]
]

{ #category : 'DB - testing' }
IdMind >> hasIdeaUID: newUuid [ 
	^ self ideas anySatisfy: [ :e | e text uid == newUuid ]
]

{ #category : 'accessing' }
IdMind >> ideas [
	^ ideas ifNil: [ ideas := Bag new ]
]

{ #category : 'DB' }
IdMind >> isDatabase [
	^ true
]

{ #category : 'accessing' }
IdMind >> lepiterDatabase [
	^ lepiterDatabase ifNil: [ lepiterDatabase := IdLeDatabase new ]
]

{ #category : 'accessing' }
IdMind >> lepiterDatabase: anIdLeDatabase [
	lepiterDatabase := anIdLeDatabase
]

{ #category : 'DB' }
IdMind >> links [
	^ links ifNil: [ links := LeExplicitLinks new ].
]

{ #category : 'accessing' }
IdMind >> newConcept [
	| lepiterPage result snippet |
	lepiterPage := LePage empty.
	snippet := IdConceptSnippet string: ''.
	lepiterPage addSnippet: snippet.
	self lepiterDatabase addPage: lepiterPage.
	result := IdConcept new
		mind: self;
		lepiterPage: lepiterPage;
		yourself.
	^ self ideas add: result
]

{ #category : 'accessing' }
IdMind >> newIdea [
	| lepiterPage result |
	lepiterPage := LePage unnamedPageWithDefaultTitle: ''.
	lepiterPage addSnippet: LeTextSnippet empty.
	self lepiterDatabase addPage: lepiterPage.
	result := IdIdea new
		mind: self;
		lepiterPage: lepiterPage;
		yourself.
	^ self ideas add: result
]

{ #category : 'DB' }
IdMind >> newUniqueUuid [
	"Return a new UUID unique to this database based on the current content"
	| newUuid |
	
	newUuid := UUID new.
	[ (self hasIdeaUID: newUuid) or: [ 
		self links hasExplicitLinkUID: newUuid ] ] whileTrue:
		[ newUuid := UUID new ].
	
	^ newUuid
]

{ #category : 'accessing' }
IdMind >> pageNamed: aString ifPresent: presentBlock ifAbsent: absentBlock [

	^ self ideas
		  detect: [ :e | e markdownString = aString ]
		  ifFound: [ :i | presentBlock value: i text ]
		  ifNone: absentBlock
]

{ #category : 'DB' }
IdMind >> removeExplicitLinks: leExplicitLinksToRemove [
	self assert: [ leExplicitLinksToRemove notNil ].

	self links removeAll: leExplicitLinksToRemove.
	^ leExplicitLinksToRemove
]

{ #category : 'DB' }
IdMind >> userEmail [
	^ userEmailString
]

{ #category : 'DB' }
IdMind >> userEmail: aString [
	userEmailString := aString
]

{ #category : 'DB' }
IdMind >> uuid [
	^ uuid ifNil: [ uuid := UUID new ]
]

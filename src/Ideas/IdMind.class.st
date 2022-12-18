Class {
	#name : #IdMind,
	#superclass : #Object,
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
	#category : #'Ideas-Core'
}

{ #category : #accessing }
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

{ #category : #persistence }
IdMind class >> restoreFrom: anObject [

	UniqueInstance := anObject.
]

{ #category : #persistence }
IdMind class >> spData [

	^ UniqueInstance.
]

{ #category : #accessing }
IdMind class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #accessing }
IdMind class >> uniqueInstance: anIdMind [
	UniqueInstance := anIdMind
]

{ #category : #DB }
IdMind >> addExplicitLink: aLink [
	aLink onAboutToAddToDatabase: self.
	self links addLink: aLink.
	aLink onAddedToDatabase: self.
]

{ #category : #DB }
IdMind >> addExplicitLinks: aCollectionOfExplicitLinks [
	self assert: [ aCollectionOfExplicitLinks notNil ].
	
	aCollectionOfExplicitLinks do: [ :eachLink | 
		self addExplicitLink: eachLink ]
]

{ #category : #accessing }
IdMind >> addIdea: anIdea [
	anIdea mind: self.
	(self lepiterDatabase children includes: anIdea lepiterPage)
		ifFalse: [ self lepiterDatabase addPage: anIdea lepiterPage ].
	^ self ideas add: anIdea
]

{ #category : #DB }
IdMind >> cachedLinksForContent: aSnippet [
	^ self links select: [ :e | e origin = aSnippet ]
]

{ #category : #accessing }
IdMind >> gtSearchIdeasFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 5;
		title: 'Ideas';
		items: [ self ideas ];
		matchSubstrings;
		itemName: #displayString
]

{ #category : #accessing }
IdMind >> gtSpotNewIdeaFor: aSearch [
	<gtSearch>
	
	^ aSearch explicit
		title: 'New Idea';
		priority: 50;
		itemName: [ :result | '+ ', result gtDisplayText ];
		search: [ :aContext | 
			| input isExisting results |
			input := aContext searchQuery trimBoth.
			isExisting := self ideas anySatisfy: [ :e | 
				e markdownString = aContext textTrimmed ].
			results := isExisting 
				ifFalse: [ { IdIdea fromString: input } ]
				ifTrue: [ {} ].
			results asAsyncStream ];
		send: [ :result | self addIdea: result ]
]

{ #category : #accessing }
IdMind >> gtViewIdeasOn: aView [
	<gtView>
	^ aView list
		title: 'Ideas' translated;
		priority: 8;
		items: [ self ideas asOrderedCollection ];
		itemText: [ :e | e markdownString asRopedText ];
		actionUpdateButton
]

{ #category : #'DB - testing' }
IdMind >> hasIdeaUID: newUuid [ 
	^ self ideas anySatisfy: [ :e | e text uid == newUuid ]
]

{ #category : #accessing }
IdMind >> ideas [
	^ ideas ifNil: [ ideas := Bag new ]
]

{ #category : #DB }
IdMind >> isDatabase [
	^ true
]

{ #category : #accessing }
IdMind >> lepiterDatabase [
	lepiterDatabase ifNotNil: [ ^ lepiterDatabase ].
	
	^ lepiterDatabase := IdLeDatabase new
		mind: self;
		yourself.
]

{ #category : #accessing }
IdMind >> lepiterDatabase: anIdLeDatabase [
	lepiterDatabase := anIdLeDatabase
]

{ #category : #DB }
IdMind >> links [
	^ links ifNil: [ links := LeExplicitLinks new ].
]

{ #category : #accessing }
IdMind >> newConcept [
	^ self addIdea: IdConcept new
]

{ #category : #accessing }
IdMind >> newIdea [
	^ self addIdea: IdIdea new.
]

{ #category : #DB }
IdMind >> newUniqueUuid [
	"Return a new UUID unique to this database based on the current content"
	| newUuid |
	
	newUuid := UUID new.
	[ (self hasIdeaUID: newUuid) or: [ 
		self links hasExplicitLinkUID: newUuid ] ] whileTrue:
		[ newUuid := UUID new ].
	
	^ newUuid
]

{ #category : #accessing }
IdMind >> pageNamed: aString ifPresent: presentBlock ifAbsent: absentBlock [

	^ self ideas
		  detect: [ :e | e markdownString = aString ]
		  ifFound: [ :i | presentBlock value: i text ]
		  ifNone: absentBlock
]

{ #category : #DB }
IdMind >> removeExplicitLinks: leExplicitLinksToRemove [
	self assert: [ leExplicitLinksToRemove notNil ].

	self links removeAll: leExplicitLinksToRemove.
	^ leExplicitLinksToRemove
]

{ #category : #DB }
IdMind >> userEmail [
	^ userEmailString
]

{ #category : #DB }
IdMind >> userEmail: aString [
	userEmailString := aString
]

{ #category : #DB }
IdMind >> uuid [
	^ uuid ifNil: [ uuid := UUID new ]
]

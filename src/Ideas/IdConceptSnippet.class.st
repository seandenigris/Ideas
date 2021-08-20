Class {
	#name : 'IdConceptSnippet',
	#superclass : 'LeTextSnippet',
	#instVars : [
		'idea'
	],
	#category : 'Ideas-Support'
}

{ #category : 'instance creation' }
IdConceptSnippet class >> forIdea: anIdea [
	"Use 'idea' terminology for now because may merge during refactoring"
	^ self new
		idea: anIdea;
		yourself
]

{ #category : 'accessing' }
IdConceptSnippet class >> leJsonV4Name [

	^ 'conceptSnippet'
]

{ #category : 'accessing' }
IdConceptSnippet >> announceTextChangedBy: anObject [
	self page ifNotNil: [ :p | p updateTitle: self string ].
	super announceTextChangedBy: anObject
]

{ #category : 'accessing' }
IdConceptSnippet >> idea [

	^ idea
]

{ #category : 'accessing' }
IdConceptSnippet >> idea: anObject [

	idea := anObject
]

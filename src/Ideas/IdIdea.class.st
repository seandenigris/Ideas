Class {
	#name : 'IdIdea',
	#superclass : 'Object',
	#instVars : [
		'text',
		'lepiterPage'
	],
	#category : 'Ideas'
}

{ #category : 'examples' }
IdIdea class >> example [
	<gtExample>
	^ self
		given: [ ]
		when: [ IdIdea new markdownString: '**Lisp** *machine*' ]
		then: [ :idea | ]
]

{ #category : 'instance creation' }
IdIdea class >> fromString: aString [
	^ self new
		markdownString: aString;
		yourself
]

{ #category : 'accessing' }
IdIdea >> asElement [
	^ IdNodeElement on: self
]

{ #category : 'accessing' }
IdIdea >> displayString [
	^ self text string
]

{ #category : 'accessing' }
IdIdea >> editor [
	^ LeSingleSnippetElement new
		initializeForPage: self lepiterPage;
		yourself
]

{ #category : 'views' }
IdIdea >> gtEditorOn: aView [
	<gtView>
	^ aView explicit
		title: 'Editor';
		priority: 10;
		stencil: [ self editor ]
]

{ #category : 'views' }
IdIdea >> gtViewGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Graph';
		priority: 5;
		painting: [ :m |
			m nodes
				stencil: [ :obj | 
					| e |
					e := self editor
					layout: BlLinearLayout new;
    border: (BlBorder paint: Color veryLightGray width: 1);
						constraintsDo: [ :c | 
							c horizontal fitContent.
							c vertical fitContent].
					e ];
				with: { self }.
			"m edges connectFrom: #parent."
			m layout horizontalTree.
			m ]
]

{ #category : 'accessing' }
IdIdea >> lepiter [
]

{ #category : 'accessing' }
IdIdea >> lepiterPage [
	^ lepiterPage
]

{ #category : 'accessing' }
IdIdea >> lepiterPage: aPage [
	lepiterPage := aPage
]

{ #category : 'accessing' }
IdIdea >> markdownString [
	^ self lepiterPage children first string
]

{ #category : 'accessing' }
IdIdea >> markdownString: aString [
	self text string: aString
]

{ #category : 'accessing' }
IdIdea >> mind [
	^ self text database
]

{ #category : 'accessing' }
IdIdea >> mind: aMind [
	self text database: aMind.
]

{ #category : 'accessing' }
IdIdea >> printOn: aStream [
	aStream nextPutAll: self markdownString
]

{ #category : 'accessing' }
IdIdea >> text [
	^ text ifNil: [ text := LeIdeaSnippet forIdea: self ]
]

{ #category : 'accessing' }
IdIdea >> text: anObject [
	text := anObject
]

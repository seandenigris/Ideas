Class {
	#name : 'IdConcept',
	#superclass : 'Object',
	#instVars : [
		'lepiterPage',
		'mind'
	],
	#category : 'Ideas-Core'
}

{ #category : 'accessing' }
IdConcept class >> defaultLepiterPage [

	^ LePage empty
		  addSnippet: (IdConceptSnippet string: '');
		  yourself
]

{ #category : 'accessing' }
IdConcept class >> example [
	<gtExample>
	^ self
		given: [ ]
		when: [ IdConcept fromString: 'Lisp' ]
		then: [ :idea | idea markdownString should equal: 'Lisp' ]
]

{ #category : 'instance creation' }
IdConcept class >> fromString: markdownString [
	
	^ self new
		initializeMarkdownString: markdownString;
		yourself
]

{ #category : 'accessing' }
IdConcept >> editor [
	^ LeSingleSnippetElement new
		initializeForPage: self lepiterPage;
		yourself
]

{ #category : 'accessing' }
IdConcept >> gtViewGraphFor: aView [
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
IdConcept >> initializeMarkdownString: aString [
	"Directly set the string to avoid update mechanism, which needs a DB"
	self lepiterPage title: aString.
	self lepiterPage children first string: aString.
]

{ #category : 'accessing' }
IdConcept >> lepiterPage [

	^ lepiterPage ifNil: [ lepiterPage := self class defaultLepiterPage  ]
]

{ #category : 'accessing' }
IdConcept >> lepiterPage: anObject [

	lepiterPage := anObject
]

{ #category : 'accessing' }
IdConcept >> markdownString [
	^ self lepiterPage children first string
]

{ #category : 'accessing' }
IdConcept >> markdownString: aString [
	^ self lepiterPage children first updateString: aString
]

{ #category : 'accessing' }
IdConcept >> mind [

	^ mind
]

{ #category : 'accessing' }
IdConcept >> mind: anObject [

	mind := anObject
]

{ #category : 'accessing' }
IdConcept >> printOn: aStream [
	aStream nextPutAll: self lepiterPage title
]

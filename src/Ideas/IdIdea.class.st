Class {
	#name : #IdIdea,
	#superclass : #Object,
	#instVars : [
		'text'
	],
	#category : #Ideas
}

{ #category : #examples }
IdIdea class >> example [
	<gtExample>
	^ self
		given: [ ]
		when: [ IdIdea new markdownString: '**Lisp machine**' ]
		then: [ :idea | ]
]

{ #category : #accessing }
IdIdea >> asElement [
	^ IdNodeElement on: self
]

{ #category : #accessing }
IdIdea >> editor [
	^ LeSingleSnippetElement new
		initializeForSnippet: self text;
		yourself
]

{ #category : #views }
IdIdea >> gtEditorOn: aView [
	<gtView>
	^ aView explicit
		title: 'Editor';
		priority: 10;
		stencil: [ self editor ]
]

{ #category : #views }
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

{ #category : #accessing }
IdIdea >> markdownString: aString [
	self text string: aString
]

{ #category : #accessing }
IdIdea >> nodeElement [
	^ BrEditableLabel new
		editor: self editor;
		aptitude: BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize;
		constraintsDo: [ :c | 
			c vertical fitContent.
			c horizontal matchParent.
			c grid vertical alignCenter ];
		when: BrEditorAcceptWish
			do: [ :aWish | Halt now. self text: aWish text ];
		text: self text.
]

{ #category : #accessing }
IdIdea >> text [
	^ text ifNil: [ text := LeTextSnippet new ]
]

{ #category : #accessing }
IdIdea >> text: anObject [
	text := anObject
]

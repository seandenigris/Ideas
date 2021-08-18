Class {
	#name : 'IdNodeElement',
	#superclass : 'BlElement',
	#instVars : [
		'model',
		'expander',
		'header'
	],
	#category : 'Ideas'
}

{ #category : 'examples' }
IdNodeElement class >> example [
	<gtExample>
	^ IdIdea example asElement
]

{ #category : 'instance creation' }
IdNodeElement class >> on: macro [
	^ self new
		model: macro;
		yourself
]

{ #category : 'accessing' }
IdNodeElement >> initialize [
	super initialize.
	
	"Adapted from GtRefactoringsElement"
	self 
		layout: BlFrameLayout new;
		constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].
	
	expander := BrExpander new
		hMatchParent;
		hMatchParent;
		aptitude: (GtCoderExpanderAptitude new
			padding: BlInsets empty;
			doNotReplaceHeader) + (BrStyleCommonAptitude new
				expanded: [ :aStyle |
					aStyle margin: (BlInsets top: 5 left: 5 bottom: 5 right: 5) ];
				collapsed: [ :aStyle |
					aStyle margin: (BlInsets top: 5 left: 5 bottom: 0 right: 5) ]);
		yourself.
	
	self addChild: expander.
	^ self
]

{ #category : 'accessing' }
IdNodeElement >> model [
	^ model
]

{ #category : 'accessing' }
IdNodeElement >> model: macro [
	model := macro.
	
	expander header: [
		self model editor
			"constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ]
			yourself" ].
	
	expander content: [ 
		| content | 
		content := BlElement new
			"constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];"
				background: Color green ].
]

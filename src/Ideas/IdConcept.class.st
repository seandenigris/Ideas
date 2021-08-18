Class {
	#name : 'IdConcept',
	#superclass : 'Object',
	#instVars : [
		'lepiterPage',
		'mind'
	],
	#category : 'Ideas'
}

{ #category : 'accessing' }
IdConcept >> editor [
	^ BrEditableLabel new
		aptitude: BrGlamorousEditableLabelAptitude new glamorousRegularFontAndSize;
		when: BrEditorAcceptWish
			do: [ :aWish | self lepiterPage title: aWish text greaseString ];
		text: self lepiterPage title.
]

{ #category : 'accessing' }
IdConcept >> gtViewGraphFor: aView [
	<gtView>
	^ aView mondrian
		title: 'Graph';
		priority: 5;
		painting: [ :m |
			m nodes
				stencil: [ :obj | self editor ];
				with: { self }.
			"m edges connectFrom: #parent."
			m layout horizontalTree.
			m ]
]

{ #category : 'accessing' }
IdConcept >> lepiterPage [

	^ lepiterPage
]

{ #category : 'accessing' }
IdConcept >> lepiterPage: anObject [

	lepiterPage := anObject
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

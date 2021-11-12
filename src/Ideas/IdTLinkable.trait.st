Trait {
	#name : #IdTLinkable,
	#category : #'Ideas-Support'
}

{ #category : #accessing }
IdTLinkable >> addLinkTo: anObject [
	| link |
	link := IdLink end: self end: anObject.
	^ IdLink db add: link
]

{ #category : #accessing }
IdTLinkable >> gtViewIdLinksOn: aView [
	<gtView>
	^ aView list
		title: 'Links' translated;
		priority: 60;
		items: [ self links asOrderedCollection ];
		send: [ :l | l ends detect: [ :e | e ~= self ] ]
]

{ #category : #accessing }
IdTLinkable >> links [
	^ IdLink db select: [ :e | e hasEndpoint: self ]
]

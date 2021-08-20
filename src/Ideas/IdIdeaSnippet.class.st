Class {
	#name : 'IdIdeaSnippet',
	#superclass : 'LeTextSnippet',
	#instVars : [
		'idea'
	],
	#category : 'Ideas'
}

{ #category : 'instance creation' }
IdIdeaSnippet class >> forIdea: anIdea [
	^ self new
		idea: anIdea;
		yourself
]

{ #category : 'accessing' }
IdIdeaSnippet >> asElement [
	^ self idea asElement
]

{ #category : 'accessing' }
IdIdeaSnippet >> idea [
	^ idea
]

{ #category : 'accessing' }
IdIdeaSnippet >> idea: anIdea [
	idea := anIdea
]

{ #category : 'accessing' }
IdIdeaSnippet >> spawnLinkTarget: aNode from: aButton [
	Halt once.
	^ super spawnLinkTarget: aNode from: aButton
]

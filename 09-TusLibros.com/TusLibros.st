!classDefinition: #TusLibrosTests category: #TusLibros!
TestCase subclass: #TusLibrosTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 21:17:58'!
test01CanCreateEmptyCart

	| aCart|
	
	aCart _ Cart new.
	
	self assert: aCart isEmpty.! !

!TusLibrosTests methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 21:27:45'!
test02CanAddABookToCart

	| aCart ISBN |
	
	aCart _ Cart new.
	ISBN _ 1230312012.
	
	aCart addBookWithISBN: ISBN.
	self deny: aCart isEmpty.
	self assert: (aCart containsBookWithISBN: ISBN).! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'isbnList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 21:29:31'!
addBookWithISBN: anISBN
	isbnList add: anISBN.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 21:36:14'!
containsBookWithISBN: anISBN
	^isbnList includes: anISBN! !

!Cart methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 21:33:13'!
initialize
	isbnList _ OrderedCollection new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 21:35:36'!
isEmpty

	^isbnList isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'np 6/4/2018 21:34:16'!
new
	^self basicNew initialize! !

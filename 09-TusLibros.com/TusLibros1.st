!classDefinition: #TusLibrosTests category: #TusLibros!
TestCase subclass: #TusLibrosTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTests methodsFor: 'testing' stamp: 'np 6/6/2018 15:49:45'!
test01CanCreateEmptyCart

	| aBookCatalog aCart |
	
	aBookCatalog _ Set new.
	aCart _ Cart withBookCatalog: aBookCatalog.
	
	self assert: aCart isEmpty.! !

!TusLibrosTests methodsFor: 'testing' stamp: 'np 6/6/2018 16:03:45'!
test02CanAddABookThatIsInTheCartCatalog

	| aCart aBook aBookCatalog |
	
	aBook _ 42.
	aBookCatalog  _ Set with: aBook.
	aCart _ Cart withBookCatalog: aBookCatalog.

	aCart addBook: aBook.
	
	self deny: aCart isEmpty.
	self assert: (aCart containsBook: aBook).! !

!TusLibrosTests methodsFor: 'testing' stamp: 'np 6/6/2018 16:05:04'!
test03CannotAddABookThatIsNotInTheCartCatalog

	| aCart aBookCatalog oneBook anotherBook |
	
	oneBook _ 42.
	anotherBook _ 43.
	aBookCatalog  _ Set with: oneBook.
	aCart _ Cart withBookCatalog: aBookCatalog.

	self assertThat: [aCart addBook: anotherBook ] failsWithError: Error 
		thatSatisfies: [ :anError |
			self assert: anError messageText  = Cart cantAddBookThatIsNotInCatalogErrorMessage.
			].
	self assert: aCart isEmpty
! !


!TusLibrosTests methodsFor: 'testing - auxiliary' stamp: 'np 6/6/2018 16:01:11'!
assertThat: aClosure failsWithError: anException thatSatisfies: anAssertionClosureAboutAnError

	[ aClosure value. self fail ]
		on: anException 
		do: anAssertionClosureAboutAnError.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'bookList catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'shopping' stamp: 'np 6/6/2018 15:47:34'!
addBook: aBook

	(catalog includes: aBook)
		ifFalse: [self error: self class cantAddBookThatIsNotInCatalogErrorMessage ].
	bookList add: aBook.! !


!Cart methodsFor: 'consulting' stamp: 'np 6/6/2018 15:43:11'!
containsBook: aBook

	^bookList includes: aBook! !

!Cart methodsFor: 'consulting' stamp: 'np 6/6/2018 15:43:06'!
isEmpty

	^bookList isEmpty! !


!Cart methodsFor: 'initialization' stamp: 'np 6/6/2018 15:43:09'!
initializeWith: aBookCatalog

	bookList _ OrderedCollection new.
	catalog _ aBookCatalog copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'np 6/6/2018 15:45:14'!
cantAddBookThatIsNotInCatalogErrorMessage
	
	^'No puede agregarse un libro que no esté en el catálogo.'! !


!Cart class methodsFor: 'instance creation' stamp: 'np 6/6/2018 16:11:40'!
withBookCatalog: aBookCatalog

	^self basicNew initializeWith: aBookCatalog.! !

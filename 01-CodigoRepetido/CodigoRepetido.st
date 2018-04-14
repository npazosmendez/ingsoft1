!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #IdiomTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!IdiomTest methodsFor: 'auxiliary' stamp: 'np 4/14/2018 17:52:04'!
assertThat: aBlockClosure failsWithError: anException 
	self assertThat: aBlockClosure failsWithError: anException thatSatisfies: [].! !

!IdiomTest methodsFor: 'auxiliary' stamp: 'NP 4/13/2018 01:24:55'!
assertThat: aClosure failsWithError: anException thatSatisfies: anAssertionClosure

	[ aClosure value. self fail ]
		on: anException 
		do: anAssertionClosure.! !

!IdiomTest methodsFor: 'auxiliary' stamp: 'NP 4/13/2018 01:15:16'!
assertThat: aClosure takesNoMoreMillisecondsThan: anNumberOfMilliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning |
		
	millisecondsBeforeRunning := Time millisecondClockValue.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < anNumberOfMilliseconds 
	
! !


!IdiomTest methodsFor: 'testing' stamp: 'NP 4/13/2018 01:12:02'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.
	
	self assertThat: [customerBook addCustomerNamed: 'John Lennon'] takesNoMoreMillisecondsThan:50.

! !

!IdiomTest methodsFor: 'testing' stamp: 'NP 4/13/2018 01:13:35'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	customerBook addCustomerNamed: paulMcCartney.	

	self assertThat: [customerBook removeCustomerNamed: paulMcCartney.] takesNoMoreMillisecondsThan:100.
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'np 4/14/2018 17:47:39'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertThat: [customerBook addCustomerNamed: ''.] failsWithError: Error thatSatisfies: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage. ].
	
	self assert: customerBook isEmpty! !

!IdiomTest methodsFor: 'testing' stamp: 'np 4/14/2018 17:49:45'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
		
	self assertThat: [customerBook removeCustomerNamed: 'Paul McCartney'.] failsWithError: NotFound.
	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: johnLennon)
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !

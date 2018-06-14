!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitFromClosure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'np 6/14/2018 14:22:51'!
test01CheckoutDebitsFromCreditCardAndReturnsAmmount

	| cart cashier usedMerchantProcessor |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	usedMerchantProcessor _ false.
	debitFromClosure _ [ usedMerchantProcessor _ true ].
	
	cashier :=  Cashier 
					toCheckout: cart 
					charging: testObjectsFactory notExpiredCreditCard 
					using: self on: testObjectsFactory today 
					registeringOn: OrderedCollection new.
	
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2).
	self assert: usedMerchantProcessor.! !

!CashierTest methodsFor: 'tests' stamp: 'DR 6/12/2018 21:59:30'!
test02CheckoutRegistersASale

	| cashier salesBook total creditCard |

	salesBook _ OrderedCollection new.
	creditCard _ testObjectsFactory notExpiredCreditCard.
 
	cashier _ testObjectsFactory
		cashierForSingleItemCartCharging: creditCard
		using: self
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook notEmpty.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'DR 6/12/2018 22:28:59'!
test03CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	
	self
		assert: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard
			using: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raisesErrorWithMessage: Cashier cartCanNotBeEmptyErrorMessage
		andLeavesEmpty: salesBook.! !

!CashierTest methodsFor: 'tests' stamp: 'np 6/14/2018 14:23:28'!
test04CanNotCheckoutWithAnExpiredCreditCart

	| salesBook |

	salesBook := OrderedCollection new.
	
	self
		assert: [ testObjectsFactory 
					cashierForSingleItemCartCharging: testObjectsFactory expiredCreditCard 
					using: self 
					registeringOn: salesBook ]
		raisesErrorWithMessage: Cashier canNotChargeAnExpiredCreditCardErrorMessage
		andLeavesEmpty: salesBook.! !

!CashierTest methodsFor: 'tests' stamp: 'DR 6/12/2018 22:46:28'!
test05CanNotCheckoutWithAStolenCreditCard

	self assertsCashierDoesNotCheckoutWhenMerchantProcessorRaisesErrorWithMessage: self stolenCreditCardErrorMessage.! !

!CashierTest methodsFor: 'tests' stamp: 'DR 6/12/2018 22:46:40'!
test06CanNotCheckoutWithInsufficientFunds

	self assertsCashierDoesNotCheckoutWhenMerchantProcessorRaisesErrorWithMessage: self insufficientFundsErrorMessage.! !

!CashierTest methodsFor: 'tests' stamp: 'np 6/14/2018 14:23:53'!
test07CashierDoesNotCallMerchantProcessorWhenCreditCardIsExpired

	| salesBook usedMerchantProcessor creditCard|
	
	usedMerchantProcessor _ false.
	debitFromClosure _ [ usedMerchantProcessor _ true ].

	salesBook := OrderedCollection new.
	creditCard _ testObjectsFactory expiredCreditCard.

	self
		should: [ testObjectsFactory 
						cashierForSingleItemCartCharging: creditCard 
						using: self registeringOn: salesBook. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self deny: usedMerchantProcessor.]
		! !


!CashierTest methodsFor: 'setup' stamp: 'np 6/11/2018 21:49:57'!
setUp 
	testObjectsFactory := StoreTestObjectsFactory new.
	debitFromClosure  _ [].! !


!CashierTest methodsFor: 'assertions' stamp: 'DR 6/12/2018 22:25:45'!
assert: aClosure raisesErrorWithMessage: anErrorMessage andLeavesEmpty: aCollection

	self
		should: aClosure
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = anErrorMessage.
			self assert: aCollection isEmpty ]! !

!CashierTest methodsFor: 'assertions' stamp: 'DR 6/12/2018 22:46:10'!
assertsCashierDoesNotCheckoutWhenMerchantProcessorRaisesErrorWithMessage: anErrorMessage

	| salesBook cashier |
	
	debitFromClosure  _ [self error: anErrorMessage ].
	
	salesBook := OrderedCollection new.
	
	cashier _ testObjectsFactory cashierForSingleItemCartCharging: testObjectsFactory notExpiredCreditCard using: self registeringOn: salesBook.
	
	self
		assert: [ cashier checkOut ]
		raisesErrorWithMessage: anErrorMessage
		andLeavesEmpty: salesBook.
! !


!CashierTest methodsFor: 'simulation' stamp: 'np 6/11/2018 21:40:39'!
debit: anAmmount from: aCreditCard

	^debitFromClosure value! !

!CashierTest methodsFor: 'simulation' stamp: 'np 6/11/2018 21:52:14'!
insufficientFundsErrorMessage

	^'Sos pobre'
	! !

!CashierTest methodsFor: 'simulation' stamp: 'np 6/11/2018 21:52:31'!
stolenCreditCardErrorMessage

	^'Los ladrones no compran'! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:05'!
itemsDo: aBlock
	
	^items do: aBlock ! !


!Cart methodsFor: 'catalog' stamp: 'HernanWilkinson 6/17/2013 18:04'!
catalog
	
	^ catalog! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart creditCard salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'np 6/11/2018 20:26:24'!
initializeToCheckout: aCart charging: aCreditCard using: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	salesBook := aSalesBook.
	merchantProcessor _ aMerchantProcessor .! !


!Cashier methodsFor: 'checkout' stamp: 'np 6/11/2018 20:26:19'!
checkOut
	
	| priceList total |
	
	priceList := cart catalog.
	total := 0.
	cart itemsDo: [ :anItem | total := total + (priceList at: anItem)].
	
	merchantProcessor debit: total from: creditCard.
	
	salesBook add: (Sale of: total).
	
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'np 6/11/2018 19:48:39'!
toCheckout: aCart charging: aCreditCard  using: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard using: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !


!CreditCard methodsFor: 'query' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #MonthOfYear category: #TusLibros!
Object subclass: #MonthOfYear
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MonthOfYear class' category: #TusLibros!
MonthOfYear class
	instanceVariableNames: ''!

!MonthOfYear class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:34'!
of: aDate 
	self shouldBeImplemented.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'query' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'np 6/11/2018 19:42:26'!
createCartWithItem
	| cart |

	cart := self createCart.
	cart add: self itemSellByTheStore.
	
	^cart! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'items' stamp: 'DR 6/12/2018 21:56:50'!
cashierForSingleItemCartCharging: aCreditCard using: aMerchantProcessor registeringOn: aSalesBook
	
	^Cashier 
		toCheckout: self createCartWithItem
		charging: aCreditCard 
		using: aMerchantProcessor
		on: self today
		registeringOn: aSalesBook.! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

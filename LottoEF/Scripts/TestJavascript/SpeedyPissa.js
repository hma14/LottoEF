
var data = [{ "email": "email1@example.com", "toppings": ["Mushrooms", "Pepperoni", "Peppers"] }, { "email": "email2@example.com", "toppings": ["Cheddar", "Garlic", "Oregano"] }, { "email": "email3@example.com", "toppings": ["Bacon", "Ham", "Pineapple"] }, { "email": "", "toppings": ["Parmesan", "Tomatoes"] }, { "email": "email4@example.com", "toppings": ["Mushrooms", "Pepperoni", "Peppers"] }, { "email": "", "toppings": ["Cheddar", "Tomatoes"] }, { "email": "email5@example.com", "toppings": ["Bacon", "Ham", "Pineapple"] }, { "email": "email6@example.com", "toppings": ["Beef", "Parmesan"] }, { "email": "", "toppings": ["Onions", "Pepperoni"] }, { "email": "", "toppings": ["Bacon", "Ham", "Pineapple"] }];


function printWinners1(inputArray) {    // Perform a QuickSort on the array.  We provide an anonymous function to do the comparisons.    
    inputArray.sort((a,b) => {        // Convert each toppings array to a string and do a string comparison        
        return a.toppings.toString().localeCompare(b.toppings.toString());    
    })        
    let previousEmail = '';    
    let previousToppingsAsString = '';    
    let previousToppingCount = 0;    
    let numberOfSimilarOrders = 0;    

    // Iterate through the array, with "order" being each item in the array.    
    inputArray.map((order) => {        
        let toppingsAsString = order.toppings.toString();        
        if (toppingsAsString === previousToppingsAsString) 
        {            
            numberOfSimilarOrders++;        
        } else {            
            if ((numberOfSimilarOrders === 1) && (previousToppingCount === 3) && (previousEmail) !== '') {                
                
                // Print out the email.                
                console.log(previousEmail);
            }
            previousToppingsAsString = toppingsAsString;
            previousEmail = order.email;
            previousToppingCount = order.toppings.length;
            numberOfSimilarOrders = 1;
        }
    });
}

function printWinners2(inputArray) {    
    let hashTable = new Map();        
    // Iterate through the array, with "order" being each item in the array.    
    inputArray.map((order) => {        
        if ((order.toppings.length === 3) && (order.email !== ''))
        {            
            // Convert the array of toppings to a string:            
            let toppingsAsString = order.toppings.toString();                        
            let matchingValue = hashTable.get(toppingsAsString);            
            if (matchingValue) {                
                // This key was already in the hash table.                
                matchingValue.duplicate = true;            
            } else {                
                // Insert a new object containing the email into the hash table, using the toppings as the key.                
                hashTable.set(toppingsAsString,{email: order.email});            
            }                                
        }    
    });        
    // Iterate through the values in the hash table, with "value" being each value.    
    hashTable.forEach((value) => {        
        if (!value.duplicate) {            
            // Print out the email.            
            console.log(value.email);
        }
    });
}

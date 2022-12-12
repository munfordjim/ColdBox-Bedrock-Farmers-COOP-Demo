let breakPoint = 390;
var elem = document.getElementsByClassName("sidebar");
var initialWindowWidth = window.innerWidth;

// if the page is opened on a smaller or mobile device (defined here as being a screen <= the breakpoint) then remove the vh-100 class.
if (initialWindowWidth <= breakPoint)
{
  for (let x of elem)
  {
    //if the current element of the loop contains the class "vh-100" then remove it.            
    if (x.classList.contains("h-100"))
    {
      x.classList.remove("h-100");
    }
  }        
}

window.addEventListener('resize', function(event)
{
  // Set the current width of the viewport
  let windowWidth = window.innerWidth;

  // if the width of the viewport changes so that its equal to the breakpoint then loop
  //  over the elements of "sidebar".
  if (windowWidth == breakPoint)
  {
    for (let x of elem) 
    {
      //if the current element of the loop contains the class "vh-100" then remove it.            
      if (x.classList.contains("h-100"))
      {
        x.classList.remove("h-100");
      }
    }
  }
  else if (windowWidth > breakPoint) // if the viewport width is greater than 390 px then we want to keep the vh-100 class applied.
  {
    for (let x of elem) 
    {
      //if the current element of the loop does NOT contain the class "vh-100" then add it.
      if (!x.classList.contains("h-100"))
      {
        x.classList.add('h-100');
      }
    }
  }
  else
  {
    for (let x of elem) 
    {
      //if the current element of the loop contains the class "vh-100" then remove it.            
      if (x.classList.contains("h-100"))
      {
        x.classList.remove("h-100");
      }
    }
  }
});

/* Code for changing active link on clicking */
// get a reference to all the menu items
var menuItem = document.getElementsByClassName("nav-link");

// loop over the menu items
for (var i = 0; i < menuItem.length; i++) 
{
// add an click event listener to each menu item.  When a menu item is clicked:
//  1.  get a reference to the menu item that currently has the active class
//  2.  remove that active class from that menu item
//  3.  add the active class to the menu item that was clicked.
menuItem[i].addEventListener("click", function () {
        var current = document.getElementsByClassName("active");
        //  getElementsByClassName returns an array like object so we reference the item 
        //  that currently has the active object as its first element:  current[0]
        current[0].classList.remove("active");
        //  "this" is a reference to the menu item that was clicked
        this.classList.add("active");
    });
}

/*  Set the focus on the first name form input if it exists */
if ( document.getElementById("inputFirstName") ) 
{
	document.getElementById("inputFirstName").focus();
}
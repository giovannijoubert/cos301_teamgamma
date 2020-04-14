/**
 * Author: Lindo "suomynonA" Mlambo
 * mlambolindo6@gmail.com
 * started on: 03/09/2019
 * All parameter names to functions/constructors etc start with an underscore
*/
class Component{
    /**
     * @brief constructor
     * @param _type html element type
     * @param _id element id
     * @param _class element class
     */
    constructor(_type, _id, _class){
        this.element = document.createElement(_type);
        this.element.setAttribute("id", _id);
        this.element.setAttribute("class", _class)
    }

    /*
     * most functions return element to allow chained function calls like jquery
    */

    /**
     * @brief set an attribute to the (this) element
     * @param _attributeName is the attribute name
     * @oaram _value is the value of the attribute
     */
    setAttribute(_attributeName, _value){
        this.element.setAttribute(_attributeName, _value);
        return this.element;
    }
    getElement(){
        return this.element;
    }
    /**
     * @brief append child to (this) element
     * @param _child is an html element you want to append to (this) element
     */
    appendChild(_child){
        this.element.appendChild(_child);
        return this.element;
    }
    /**
     * @brief append text node to (this) element
     * @param _text raw text you want appended 
     */
    appendText(_text){
        this.appendChild(document.createTextNode(_text));
    }
}

class InputComponent extends Component{
    constructor(_inputType, _id, _class){
        super("input", _id, _class);
        this.setAttribute("type", _inputType);
    }
}

class ButtonComponent extends Component{
    constructor(_id, _class, _label){
        super("Button", _id, _class)
        this.appendText(_label);
    }
}

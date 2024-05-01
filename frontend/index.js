import { html, css, LitElement } from 'lit';
import axios from 'axios';

let axiosConfig = {
    headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Access-Control-Allow-Origin': '*'
    }
};

class ThoughtBox extends LitElement {

    static styles = css`
        .thought-input-container {
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border: 1px solid black;
        }

        .thought-input-container textarea {
            width: 70%;
            min-height: 4rem;
            resize: vertical;
        }

        .thought-input-container button {
            width: 20%;
            height: 2rem;
        }
    `;

    render() {
        return html`
            <div class="thought-input-container">
                <textarea id="thought-input"></textarea>
                <button @click=${this.storeThought}>Store thought</button>
            </div>
        `;
    }

    async storeThought() {
        var inputBox = this.shadowRoot.getElementById('thought-input');
        var thought = inputBox.value;
        if (!thought) {
            alert("Thought cannot be empty");
            return;
        }
        inputBox.value = '';

        try {
            const response = await axios.post('https://cloudx-backend-app-820548440a04bd6e.azurewebsites.net/thoughts', {
                thought: thought
            }, axiosConfig);
            console.log(response.data);
            alert("Thought stored successfully");
        } catch (error) {
            console.error(error);
        }
    }
}
window.customElements.define('thought-box', ThoughtBox);
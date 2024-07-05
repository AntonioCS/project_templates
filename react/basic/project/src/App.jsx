
import myPic from './assets/react-core-concepts.png';

function Header() {

    let myName = 'John Doe';
    return (
        <header>
            <img src={myPic} alt="Stylized atom"/>
            <h1>React</h1>
            <p>
                {myName} - React
            </p>
        </header>
    );

}


function App() {
    return (
        <div>
            <Header/>
            <main>
                <h2>Time to get started!</h2>
            </main>
        </div>
    );
}

export default App;

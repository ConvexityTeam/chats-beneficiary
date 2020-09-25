import React from 'react';
import { Link } from 'react-router-dom';
import '../styles/app.css'

function Register() {
    return (
        <>
            <section class="body-bg min-h-screen pt-12 md:pt-20 pb-6 px-2 md:px-0" style={{font:'Lato'}}>
            <header className="max-w-lg mx-auto">
                <Link to="#">
                    <h1 className="text-4xl font-bold text-white text-center">Chats NGO</h1>
                </Link>
            </header>

            <main className="bg-white max-w-lg mx-auto p-8 md:p-12 my-10 rounded-lg shadow-2xl">
                <section>
                    <h3 className="font-bold text-2xl">Welcome,</h3>
                    <p className="text-gray-600 pt-2">Sign in to your account.</p>
                </section>

                <section className="mt-10">
                    <form className="flex flex-col" method="POST" action="#">
                        <div className="mb-6 pt-3 rounded bg-gray-200">
                            <label className="block text-gray-700 text-sm font-bold mb-2 ml-3" for="email">Name of Organization</label>
                            <input type="text" id="email" className="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-purple-600 transition duration-500 px-3 pb-3" />
                        </div>
                        <div className="mb-6 pt-3 rounded bg-gray-200">
                            <label className="block text-gray-700 text-sm font-bold mb-2 ml-3" for="email">Email</label>
                            <input type="text" id="email" className="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-purple-600 transition duration-500 px-3 pb-3" />
                        </div>
                        <div className="mb-6 pt-3 rounded bg-gray-200">
                            <label className="block text-gray-700 text-sm font-bold mb-2 ml-3" for="password">Password</label>
                            <input type="password" id="password" className="bg-gray-200 rounded w-full text-gray-700 focus:outline-none border-b-4 border-gray-300 focus:border-purple-600 transition duration-500 px-3 pb-3" />
                        </div>
                        <div className="flex justify-end">
                            <Link to="#" className="text-sm text-purple-600 hover:text-purple-700 hover:underline mb-6">Forgot your password?</Link>
                        </div>
                        <button className="bg-purple-600 hover:bg-purple-700 text-white font-bold py-2 rounded shadow-lg hover:shadow-xl transition duration-200" type="submit">Create Account</button>
                    </form>
                </section>
            </main>

            <div className="max-w-lg mx-auto text-center mt-12 mb-6">
                <p className="text-white">Have an account? <Link to="#" className="font-bold hover:underline">Register</Link>.</p>
            </div>

            <footer className="max-w-lg mx-auto flex justify-center text-white">
                <Link to="#" className="hover:underline">Contact</Link>
                <span className="mx-3">•</span>
                <Link to="#" className="hover:underline">Privacy</Link>
            </footer>
            </section>
        </>
    )   
}

export default Register
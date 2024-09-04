import React, { useState } from 'react';
import './getintouch.css'; // Import your CSS file

export function Getintouch() {
    const [formData, setFormData] = useState({
        firstName: '',
        lastName: '',
        company: '',
        jobTitle: '',
        email: '',
        businessGoals: ''
    });

    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prevState => ({
            ...prevState,
            [name]: value
        }));
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        // Add your logic here for handling form submission
        console.log('Form submitted:', formData);
        
        // Reset form fields
        setFormData({
            firstName: '',
            lastName: '',
            company: '',
            jobTitle: '',
            email: '',
            businessGoals: ''
        });
    };

    return (
        <div className="container">
            <h2>Get in Touch</h2>
            <form onSubmit={handleSubmit}>
                <div className="form-group">
                    <label htmlFor="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName" value={formData.firstName} onChange={handleChange} required />
                </div>
                <div className="form-group">
                    <label htmlFor="lastName">Last Name</label>
                    <input type="text" id="lastName" name="lastName" value={formData.lastName} onChange={handleChange} required />
                </div>
                <div className="form-group">
                    <label htmlFor="company">Company</label>
                    <input type="text" id="company" name="company" value={formData.company} onChange={handleChange} required />
                </div>
                <div className="form-group">
                    <label htmlFor="jobTitle">Job Title</label>
                    <input type="text" id="jobTitle" name="jobTitle" value={formData.jobTitle} onChange={handleChange} required />
                </div>
                <div className="form-group">
                    <label htmlFor="email">Email</label>
                    <input type="email" id="email" name="email" value={formData.email} onChange={handleChange} required />
                </div>
                <div className="form-group">
                    <label htmlFor="businessGoals">Business Goals</label>
                    <textarea id="businessGoals" name="businessGoals" value={formData.businessGoals} onChange={handleChange} required />
                </div>
                <button type="submit">Submit</button>
            </form>
        </div>
    );
}

export default Getintouch;

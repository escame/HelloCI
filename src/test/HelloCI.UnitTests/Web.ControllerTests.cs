using HelloCI.Web.Controllers;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace HelloCI.UnitTests
{
    [TestFixture]
    class HomeControllerTests
    {
        HomeController controller;

        [SetUp]
        public void Setup()
        {
            controller = new HomeController();
        }

        [Test]
        public void IndexActionReturnsView()
        {
            // Act
            var viewResult = controller.Index() as ViewResult;

            // Assert
            Assert.IsInstanceOf<ViewResult>(viewResult);
            Assert.AreEqual("Welcome to ASP.NET MVC!", viewResult.ViewBag.Message);
        }

        [Test]
        public void AboutActionReturnsView()
        {
            // Act
            var viewResult = controller.About() as ViewResult;

            // Assert
            Assert.IsInstanceOf<ViewResult>(viewResult);
        }
    }
}

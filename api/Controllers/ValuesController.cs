using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using primeapi.lib;

namespace primeapi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PrimesController : ControllerBase
    {
        // GET api/primes
        [HttpGet]
        public ActionResult<IEnumerable<string>> Get()
        {
            return new string[] { "2", "3","5","7","11","13","17","19","23","29","..." };
        }

        // GET api/primes/5
        [HttpGet("{id}")]
        public ActionResult<bool> Get(int id)
        {
            return new PrimeService().IsPrime(id);
        }

        // POST api/primes
        [HttpPost]
        public void Post([FromBody] string value)
        {
        }

        // PUT api/primes/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/primes/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }
    }
}

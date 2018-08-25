using System;
using primeapi.lib;
using Xunit;

namespace tests
{
    public class PrimeTests
    {
        [Fact]
        public void TwoIsPrime() => Assert.Equal(true, new PrimeService().IsPrime(2));
        
        [Fact]
        public void FiveIsPrime() => Assert.Equal(true, new PrimeService().IsPrime(5));
             
        [Fact]
        public void NineIsNotPrime() => Assert.Equal(false, new PrimeService().IsPrime(9));
        
    }
}

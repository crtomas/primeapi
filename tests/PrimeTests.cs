using System;
using primeapi.lib;
using Xunit;

namespace tests
{
    public class PrimeTests
    {
        [Fact]
        public void TwoIsPrime() => Assert.True(new PrimeService().IsPrime(2));
        
        [Fact]
        public void FiveIsPrime() => Assert.True(new PrimeService().IsPrime(5));
             
        [Fact]
        public void NineIsNotPrime() => Assert.False(new PrimeService().IsPrime(9));
        
    }
}
